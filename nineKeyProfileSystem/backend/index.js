var bodyParser = require('body-parser')
var express = require("express");
var fs = require("fs");
var jsonfile = require("jsonfile");

var database = require("./database/database.js");
var profile = require("./database/profile.js");

var app = express();
app.use(bodyParser.json());

app.get("/", function(req, res) {
	db.createUser("eriwang");
	res.send("added someone");
});

// For the alpha, we only allow use of this test user
const testUserId = "CzH3YhwZItXXN9IdiCjV5C57Tab2";

// TODO: modularize into different files

app.get("/", function(req, res) {

});

// Get list of profiles for user, but not yet the words
// TODO: allow more than just this profile
app.get("/api/v1/profiles", function(req, res) {
	var db = new database.db();

	db.getProfiles(testUserId)
		.onComplete(function(data) {
			res.send(data);
		});
});

// Create new profile for user
app.post("/api/v1/profiles", function(req, res) {
	// FIXME: need validation
	var db = new database.db();

	db.createProfile(testUserId, req.body.profileName)
		.onComplete(function() {
			res.send("added!");
		});
});

// Edit profile for user
app.put("/api/v1/profiles", function(req, res) {
	console.log(res.body);
	// TODO: make this function
	res.send(res.body);
});

// Delete profile for user
app.delete("/api/v1/profiles/:profileName", function(req, res) {
	var db = new database.db();
	var profileName = req.params.profileName;

	db.deleteProfile(testUserId, profileName)
		.onComplete(function() {
			res.send("deleted!");
		});
})

// Get list of words for a specific profile for the user
app.get("/api/v1/words/:profileName", function(req, res) {
	// FIXME: need validation
	var db = new database.db();
	var profileName = req.params.profileName;

	db.getWords(testUserId, profileName)
		.onComplete(function(data) {
			res.send({
				text: data
			});
		});
});

// Edit word list for user
app.put("/api/v1/words/:profileName", function(req, res) {
	var profileName = req.params.profileName;
	console.log(res.body);
	// TODO: make this function
	res.send(res.body);
});

var server = app.listen(process.env.PORT || 3000, function() {
	var port = server.address().port;
	console.log(`App listening on port ${port}`);
});