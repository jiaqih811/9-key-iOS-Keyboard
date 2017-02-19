module.exports = {
	db: db
}

var profile = require("./profile.js");

var admin = require("firebase-admin");
var serviceAccount = require("./firebase-admin-cred.json");

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: "https://keyboard-b3485.firebaseio.com/"
});

var firebaseDb = admin.database();

/*
	Acts as the proxy between the firebase DB and the nodejs app
*/
// TODO: are Javascript classes any better than this? they might be...
// TODO: sessions instead of passing params?
// TODO: look into "async.js" instead of this solution for asynchronousness
function db() {
	var queuedFunctions = [];

	// runs all functions assigned by "onComplete"
	function runQueuedFunctions(data) {
		for (var func of queuedFunctions) {
			func(data);
		}
	}

	// sets a callback to be called after the db's operation completes, should take in either one or no arguments
	this.onComplete = function(func) {
		queuedFunctions.push(func);
	}

	// gets all profiles
	// callbacks should take in the JSON object of the user's profiles
	this.getProfiles = function(userId) {
		var ref = firebaseDb.ref(`/users/${userId}`);
		ref.once("value", function(dataSnapshot) {
			console.log(dataSnapshot.val());
			runQueuedFunctions(dataSnapshot.val());
		});
		return this;
	}

	this.createProfile = function(userId, profile) {
		// TODO: be able to create a new profile
		return this;
	}

	this.updateProfile = function(profile) {
		// TODO: be able to update a profile

		return this;
	}

	this.deleteProfile = function(profileName) {
		return this;
	}
}