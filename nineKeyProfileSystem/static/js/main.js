$(function() {
	$.ajax("/api/v1/profiles", {
		type: "GET",
		success: showProfiles
	});

	$("body").on("click", ".profile", function() {
		console.log(`i was clicked: ${this.innerHTML}`);
		$(".selected").removeClass("selected");
		$(this).addClass("selected");
	});

	$("#profile_new").submit(function(e) {
		e.preventDefault();

		createProfile($("#profile_new_input").val());
	});
});

function showProfiles(profileDict) {
	function appendProfile(profile) {
		var profileHtml = `<div class="profile">${profile}</div>`;
		$("#profile_list").prepend(profileHtml);
	}

	var profileList = [];
	for (var profile in profileDict) {
		profileList.push(profile);
	}
	profileList.sort().forEach(appendProfile);
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

// TODO: Client side validation
function createProfile(profile) {
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