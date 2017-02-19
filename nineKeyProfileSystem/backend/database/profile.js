/*
	This file stores the structure for the profile "object".
	The profile object represents all state that the keyboard needs to know
*/

module.exports = {
	Profile: Profile
}

// TODO: Layout name?
function Profile(username, profileName, words) {
	// this.username = username;
	// this.profileName = profileName;
	// this.layoutName;
	this.words = words;
}