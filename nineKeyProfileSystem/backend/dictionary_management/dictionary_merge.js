module.exports = {
	mergeDictionaries: mergeDictionaries
};

var fs = require("fs");

var dict = require("./dictionary.js");

/*
	Merges two dictionaries, given the filenames
*/
function mergeDictionaries(filename1, filename2) {
	var d1 = new dict.dictionary(filename1);
	var d2 = new dict.dictionary(filename2);

	d1.merge(d2);
	d1.save("asdf");
	
} 