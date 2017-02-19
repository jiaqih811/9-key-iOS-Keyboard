module.exports = {
	db: db
}

var fs = require("fs");
var firebase = require("firebase");
var google = require("googleapis");

var profile = require("./profile.js");

firebase.initializeApp({
	apiKey: "AIzaSyAG-cHgQJXszHgFo7IuBSxrsYg0Z8yga_0",
	databaseURL: "https://keyboard-b3485.firebaseio.com/",
	storageBucket: "gs://keyboard-b3485.appspot.com"
});

var gcloud = require('google-cloud')({
	projectId: "639200601818",
	credentials: require("./gcloud-storage-cred.json")
});

var firebaseDb = firebase.database();
var gcloudStorage = gcloud.storage();

/*
	Acts as the proxy between the firebase DB and the nodejs app
*/
// TODO: are Javascript classes any better than this? they might be...
// TODO: sessions instead of passing params for userid
// TODO: look into "async.js" instead of this solution for asynchronousness
function db() {
	var queuedFunctions = [];

	// gets all profiles
	// callbacks should take in the JSON object of the user's profiles
	this.getProfiles = function(userId) {
		var ref = firebaseDb.ref(`/users/${userId}/profiles`);
		ref.once("value", function(dataSnapshot) {
			var profiles = dataSnapshot.val();
			console.log(profiles);
			runQueuedFunctions(profiles);
		});
		
		return this;
	}

	this.getWords = function(userId, profileName) {
		var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
		var remoteReadStream = bucket.file(`${userId}/${profileName}.txt`).createReadStream();
		var data = "";

		remoteReadStream.on("data", function(chunk) {
			data += chunk;
		});
		remoteReadStream.on("end", function() {
			var words = data.split("\n");
			words.sort();
			runQueuedFunctions(words);
		});

		// FIXME: if possible, more descriptive
		remoteReadStream.on("error", function() {
			throw new Error("File reading returned an error!");
		});

		return this;
	}

	this.createProfile = function(userId, profileName) {
		// FIXME: assert that the profile name doesn't already exist
		var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
		var remoteWriteStream = bucket.file(`${userId}/${profileName}.txt`).createWriteStream();
		remoteWriteStream.write("this\nis\na\ntest\nprofile\n");
		remoteWriteStream.end();

		var ref = firebaseDb.ref(`users/${userId}/profiles`);
		var newProfile = {};
		newProfile[profileName] = `${profileName}.txt`;
		ref.update(newProfile, function(error) {
			if (error) {
				throw new Error("Something bad happened: " + error);
			}
			else {
				runQueuedFunctions();
			}
		})

		return this;
	}

	this.updateProfile = function(profile) {
		// TODO: be able to update a profile
		return this;
	}

	this.deleteProfile = function(userId, profileName) {
		// FIXME: error handling
		var ref = firebaseDb.ref(`users/${userId}/profiles/${profileName}`);
		ref.remove(function() {
			var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
			bucket.file(`${userId}/${profileName}.txt`).delete(function(error) {
				if (error) {
					throw new Error("Something bad happened: " + error);
				}
				else {
					runQueuedFunctions();
				}
			});	
		});
		return this;
	}

	// sets a callback to be called after the db's operation completes, should take in either one or no arguments
	this.onComplete = function(func) {
		queuedFunctions.push(func);
	}

	// runs all functions assigned by "onComplete"
	function runQueuedFunctions(data) {
		for (var func of queuedFunctions) {
			func(data);
		}
	}
}