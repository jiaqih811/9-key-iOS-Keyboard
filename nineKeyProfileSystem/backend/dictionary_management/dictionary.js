module.exports = {
	dictionary: dictionary
};

var fs = require("fs");

/*
	Represents a dictionary, either stored on firebase or sent by a user
*/
function dictionary(filename) {
	var fileContents = fs.readFileSync(filename, "utf-8");
	var lines = fileContents.split("\n");
	
	// TODO: file validation? i.e. no duplicates, no empty strings, etc.
	var wordToFrequency = {};
	for (var line of lines) {
		var lineSep = line.split("\t");
		if (lineSep.length == 2) {
			wordToFrequency[lineSep[0]] = parseInt(lineSep[1]);	
		}
	}

	this.getWordFrequencies = function() {
		return wordToFrequency;
	}

	this.merge = function(dict) {
		for (var word in dict.getWordFrequencies()) {
			if (word in wordToFrequency) {
				wordToFrequency[word] = Math.max(wordToFrequency[word], dict.getWordFrequencies()[word]);
			}
			else {
				wordToFrequency[word] = dict.getWordFrequencies()[word];
			}
		}
	}

	this.save = function(filename) {
		var fileString = "";
		for (var word of getSortedWordList()) {
			var wordFrequency = wordToFrequency[word];
			fileString += `${word}\t${wordFrequency}\n`
		}

		fs.writeFileSync(filename, fileString, "utf-8");
	}

	// TODO: for a slight speed boost on the app, sort by the frequency instead
	function getSortedWordList() {
		var words = [];
		for (var word in wordToFrequency) {
			words.push(word);
		}

		return words.sort();
	}
}