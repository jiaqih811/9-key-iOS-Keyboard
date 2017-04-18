module.exports = {
	dictionary: dictionary
};

var fs = require("fs");

/*
	Represents a dictionary, either stored on firebase or sent by a user
*/
function dictionary(content) {
	var lines = content.split("\n");
	
	// TODO: file validation? i.e. no duplicates, no empty strings, etc.
	var wordToFrequency = {};
	for (var line of lines) {
		var lineSep = line.split("\t");
		if (lineSep.length == 2) {
			wordToFrequency[lineSep[0]] = parseInt(lineSep[1]);	
		}
	}

	this.addText = function(text) {
		text = filterText(text);
		for (var word of text.split(" ")) {
			if (word != "") {
				incrementWordFrequency(word);
			}
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

	function filterText(text) {
		text = text.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()"@<>]/g,"")
			.replace(/\n/, " ")
			.replace(/\s{2,}/g, " ");
		return text.toLowerCase();
	}

	function incrementWordFrequency(word) {
		if (!(word in wordToFrequency)) {
			wordToFrequency[word] = 0;
		}
		wordToFrequency[word] += 1;
	}
}