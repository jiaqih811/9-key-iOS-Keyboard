var bodyParser = require('body-parser')
var express = require("express");
var fileUpload = require("express-fileupload");
var fs = require("fs");
var jsonfile = require("jsonfile");
var path = require("path");

var database = require("./database/database.js");
var dict = require("./dictionary_management/dictionary.js");

var app = express();
app.use(bodyParser.json());
app.use(fileUpload());

app.use(express.static("static"));

// For the beta, we only allow use of this test user
const TEST_USER_ID = "CzH3YhwZItXXN9IdiCjV5C57Tab2";

// TODO: modularize into different files

app.get("/", function(req, res) {
	res.sendFile(path.join(__dirname, "static/index.html"));
});

/*
	Returns a JSON object of profiles:
	{
		"profiles": {
			"<profile_name>": "<profile_name>.txt",
			"<profile_name>": "<profile_name>.txt",
			...
		}
	}
*/
// TODO: the client really doesn't need this much info...
app.get("/api/v1/profiles", function(req, res) {
	var db = new database.db();

	db.getProfiles(TEST_USER_ID)
		.onComplete(function(data) {
			res.send(data);
		});
});

/*
	Returns a JSON object with the link to the text file for the profile:
	{
		"url": "<text file url>"
	}
*/
app.get("/api/v1/profiles/:profileName", function(req, res) {
	var db = new database.db();

	db.getLinkForProfile(TEST_USER_ID, req.params.profileName)
		.onComplete(function(link) {
			res.send({url: link});
		});
});

/*
	Takes a multipart/form-data request with text file "data"
	and merges the client dict with the server dict.
	Used by the iOS app.
*/
app.post("/api/v1/dict/:profileName", function(req, res) {
	var db = new database.db();
	var requestDict = new dict.dictionary(req.files.data.data.toString());

	db.mergeDicts(TEST_USER_ID, req.params.profileName, requestDict)
		.onComplete(function() {
			res.send("OK");
		});
});

/*
	Takes a JSON object 
	{
		"text": "<some text>"
	}
	and adds the text to the dictionary specified.
*/
app.put("/api/v1/dict/add/:profileName", function(req, res) {
	var db = new database.db();

	db.addText(TEST_USER_ID, req.params.profileName, req.body.text)
		.onComplete(function() {
			res.send("OK");
		});
});

/*
	Takes a JSON object
	{
		"profileName": "<profile name>"
	}
	and creates a new profile with that name using the default dictionary.
*/
app.post("/api/v1/profiles", function(req, res) {
	// FIXME: need validation
	var db = new database.db();

	db.createProfile(TEST_USER_ID, req.body.profileName)
		.onComplete(function() {
			res.send("added!");
		});
});

/*
	Deletes the specified profile.
*/
// TODO: look into standard RESTful API syntax for deletes
app.delete("/api/v1/profiles/:profileName", function(req, res) {
	var db = new database.db();
	var profileName = req.params.profileName;

	db.deleteProfile(TEST_USER_ID, profileName)
		.onComplete(function() {
			res.send("deleted!");
		});
});

var server = app.listen(process.env.PORT || 3000, function() {
	var port = server.address().port;
	console.log(`App listening on port ${port}`);
});
