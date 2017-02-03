"use strict";

var bodyParser = require('body-parser')
var express = require("express");
var app = express();
var fs = require("fs");
var jsonfile = require("jsonfile");
app.use(bodyParser.json());

app.get("/", function(req, res) {
	res.send("Hello world!");
});

// Get list of profiles for user
app.get("/api/v1/profiles", function(req, res) {
	console.log("lol");
	res.send("hi");
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