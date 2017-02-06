var bodyParser = require('body-parser')
var express = require("express");
var fs = require("fs");
var jsonfile = require("jsonfile");

var database = require("./database/database.js");
var profile = require("./database/profile.js");

var app = express();
app.use(bodyParser.json());

var db = database.db;

app.get("/", function(req, res) {
	db.createUser("eriwang");
	res.send("added someone");
});

// Get list of profiles for user
app.get("/api/v1/profiles", function(req, res) {
	var p = new profile.Profile("eriwang", "tmp", ["hi", "bye"]);
	db.createProfile(p)
	res.send(db.viewProfiles("eriwang"));
});

// Create new profile for user
app.post("/api/v1/profiles", function(req, res) {
	consle.log(res.body);
	res.send(res.body);
});

// Edit profile for user
app.put("/api/v1/profiles", function(req, res) {
	consle.log(res.body);
	res.send(res.body);
});

var server = app.listen(3000, function() {
	var host = server.address().address;
	var port = server.address().port;

	console.log("App listening at http://%s:%s", host, port);
});