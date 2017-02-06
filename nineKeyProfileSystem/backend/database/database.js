module.exports = {
	db: db()
}

// TODO: since we are using Firebase, most of this code will just make calls to that eventually
function db() {
	var usernameToProfiles = {}

	function validateUser(username) {
		if (!(username in usernameToProfiles)) {
			// FIXME: error
		}
	}

	function validateProfile(profile) {
		validateUser(profile.username);
		if (!(profile.profileName in usernameToProfiles[profile.username])) {
			// FIXME: error
		}
	}

	return {
		createUser: function(username) {
			if (username in usernameToProfiles) {
				// FIXME: throw an error of some sort here and catch it (?)
			}
			else {
				usernameToProfiles[username] = {};
			}
		},
		viewProfiles: function(username) {
			validateUser(username);
			return usernameToProfiles[username];
		},
		createProfile: function(profile) {
			validateUser(profile.username);
			console.log(profile.username);
			console.log(profile);
			if (profile.profileName in usernameToProfiles[profile.username]) {
				// FIXME: error
			}

			usernameToProfiles[profile.username][profile.profileName] = profile;
		},
		editProfile: function(profile) {
			validateProfile(profile);

		},
		deleteProfile: function(profileName) {
			validateProfile(profile);
		}
	}
}