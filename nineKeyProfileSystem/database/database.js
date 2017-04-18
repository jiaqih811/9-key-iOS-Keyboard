module.exports = {
	db: db
}

var fs = require("fs");
var firebase = require("firebase");

var dict = require("../dictionary_management/dictionary.js");

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
// TODO: how do I even modularize this??
function db() {
	var queuedFunctions = [];

	/*
		Gets all of the user's profiles.
		Callbacks registered via onComplete should take in the JSON object of the user's profiles.
	*/
	this.getProfiles = function(userId) {
		var ref = firebaseDb.ref(`/users/${userId}/profiles`);
		ref.once("value", function(dataSnapshot) {
			var profiles = dataSnapshot.val();
			runQueuedFunctions(profiles);
		});
		
		return this;
	}

	/*
		Gets the link for the specified profile.
		Callbacks registered via onComplete should take in the string representing the file URL.
	*/
	this.getLinkForProfile = function(userId, profileName) {
		var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
		var file = bucket.file(`${userId}/${profileName}.txt`);

		var expirationDate = new Date();
		expirationDate.setDate(expirationDate.getDate() + 1);
		file.getSignedUrl({
			action: "read",
			expires: expirationDate
		}, function(err, url) {
			if (err) {
				console.log(err);
				throw err;
			}
			runQueuedFunctions(url);
		});

		return this;
	}

	/*
		Merges the dictionary from the request with the one on the server.
		Callbacks registered via onComplete should take no parameters.
	*/
	this.mergeDicts = function(userId, profileName, requestDict) {
		function _mergeDictsImpl(serverDict, file, bucket) {
			serverDict.merge(requestDict);
			uploadDict(serverDict, profileName, file, bucket);
		}

		downloadProfileData(userId, profileName, _mergeDictsImpl);
		return this;
	}

	/*
		Adds the text given to the dictionary on the server.
		Callbacks registered via onComplete should take no parameters.
	*/
	this.addText = function(userId, profileName, text) {
		function _addTextImpl(serverDict, file, bucket) {
			serverDict.addText(text);
			uploadDict(serverDict, profileName, file, bucket);
		}

		downloadProfileData(userId, profileName, _addTextImpl);
		return this
	}

	/*
		Creates a profile using the default profile as a base.
		Callbacks registered via onComplete should take no parameters.
	*/
	this.createProfile = function(userId, profileName) {
		const SYSTEM_DEFAULT_FILE = "System/default.txt";

		// FIXME: assert that the profile name doesn't already exist
		var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
		var defaultFile = bucket.file(SYSTEM_DEFAULT_FILE);
		var newProfileFile = bucket.file(`${userId}/${profileName}.txt`);
		defaultFile.copy(newProfileFile);

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

	/*
		Deletes the specified profile.
		Callbacks registered via onComplete should take no parameters.
	*/
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

	/*
		Sets a callback to be called after the db's operation completes.
		Callbacks should take one or no arguments.
	*/
	this.onComplete = function(func) {
		queuedFunctions.push(func);
	}

	/*
		Downloads the dictionary, then calls onFinished(dict, file)
		where "dict" is a dictionary object and "file" is a reference to the firebase storage file
	*/
	function downloadProfileData(userId, profileName, onFinished) {
		var bucket = gcloudStorage.bucket("keyboard-b3485.appspot.com");
		var file = bucket.file(`${userId}/${profileName}.txt`);
		var remoteReadStream = file.createReadStream();

		var data = "";
		remoteReadStream.on("data", function(chunk) {
			data += chunk;
		});
		remoteReadStream.on("end", function() {
			var serverDict = new dict.dictionary(data);
			onFinished(serverDict, file, bucket);
		});
		// FIXME: if possible, more descriptive
		remoteReadStream.on("error", function() {
			throw new Error("File reading returned an error!");
		});
	}

	/*
		Deletes the old dictioanry on firebase, then uploads the new one.
	*/
	// TODO: runs queued functions on end... what if I want to do something before that?
	function uploadDict(serverDict, profileName, file, bucket) {
		serverDict.save(`${profileName}.txt`);

		// TODO: we're pretending that this doesn't crash midway or anything...
		file.delete().then(
			function() {
				bucket.upload(`${profileName}.txt`, {"destination": file}, runQueuedFunctions);
			}
		);
	}

	/*
		Runs all functions set by onComplete.
	*/
	function runQueuedFunctions(data) {
		for (var func of queuedFunctions) {
			func(data);
		}
	}
}