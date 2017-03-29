var bodyParser = require('body-parser')
var express = require("express");
var fileUpload = require("express-fileupload");
var fs = require("fs");
var jsonfile = require("jsonfile");
var path = require("path");

var database = require("./database/database.js");
var dict = require("./dictionary_management/dictionary.js");
var profile = require("./database/profile.js");

var app = express();
app.use(bodyParser.json());
app.use(fileUpload());

// For the alpha, we only allow use of this test user
const TEST_USER_ID = "CzH3YhwZItXXN9IdiCjV5C57Tab2";

// TODO: modularize into different files

app.get("/", function(req, res) {
	res.sendFile(path.join(__dirname, "index.html"));
});

// Get list of profiles for user
app.get("/api/v1/profiles", function(req, res) {
	var db = new database.db();

	db.getProfiles(TEST_USER_ID)
		.onComplete(function(data) {
			res.send(data);
		});
});

// Perform the actual dictionary merge
app.post("/api/v1/dict/:profileName", function(req, res) {
	var db = new database.db();
	var requestDict = new dict.dictionary(req.files.data.data.toString());
	console.log(req.params.profileName);

	db.getDict(TEST_USER_ID, req.params.profileName)
		.onComplete(function(dbDict) {
			dbDict.merge(requestDict);
			res.send(dbDict.getWordFrequencies());
		});
});

// Create new profile for user
app.post("/api/v1/profiles", function(req, res) {
	// FIXME: need validation
	console.log(req.body);
	var db = new database.db();

	db.createProfile(TEST_USER_ID, req.body.profileName)
		.onComplete(function() {
			res.send("added!");
		});
});

// Edit profile for user (TODO: make it actually do something)
app.put("/api/v1/profiles", function(req, res) {
	res.send(res.body);
});

// Delete profile for user
// TODO: look into standard RESTful API syntax for deletes
app.delete("/api/v1/profiles/:profileName", function(req, res) {
	var db = new database.db();
	var profileName = req.params.profileName;

	db.deleteProfile(TEST_USER_ID, profileName)
		.onComplete(function() {
			res.send("deleted!");
		});
});

// Get list of words for a specific profile for the user
app.get("/api/v1/words/:profileName", function(req, res) {
	// FIXME: need validation
	var db = new database.db();
	var profileName = req.params.profileName;

	db.getWords(TEST_USER_ID, profileName)
		.onComplete(function(data) {
			res.send({
				words: data
			});
		});
});

// Edit word list for user (TODO: make it actually do something)
app.put("/api/v1/words/:profileName", function(req, res) {
	res.send(res.body);
});

var server = app.listen(process.env.PORT || 3000, function() {
	var port = server.address().port;
	console.log(`App listening on port ${port}`);
});