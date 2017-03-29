console.log("481 sucks");

$(function() {
	// $.ajax("/api/v1/profiles", {
	// 	type: "GET",
	// 	success: showProfiles
	// });
});

function foo() {
	var formData = new FormData(document.getElementById("test"));
	$.ajax("/api/v1/dict/correct", {
		type: "POST",
		data: formData,
		mimeType: "multipart/form-data",
		contentType: false,
		processData: false,
		success: function(data) {
			console.log(data);
			console.log("DONE");
		}
	});
}

function showProfiles(profiles) {
	console.log(profiles);
	var profileList = "";
	for (var profile in profiles) {
		profileList += `<li>${profile}`
		profileList += `<button onclick="showWords('${profile}')">See my words!</button>`
		profileList += "</li>"
	}

	$("#profile_view_list").html(profileList);
}

function showWords(profileName) {
	$.ajax(`/api/v1/words/${profileName}`, {
		type: "GET",
		success: function(wordData) {
			console.log(wordData);
			$("#word_view").html(wordData.words.join(", "));
		}
	});
}

function createProfile() {
	var profile = $("#profile_create_name").val();
	$.ajax("/api/v1/profiles", {
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({profileName: profile}),
		success: function() {
			window.location.reload();
		}
	})
}

function deleteProfile() {
	var profileName = $("#profile_delete_name").val();
	$.ajax(`/api/v1/profiles/${profileName}`, {
		type: "DELETE",
		success: function() {
			window.location.reload();
		}
	})
}