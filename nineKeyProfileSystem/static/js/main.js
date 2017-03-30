// TODO: maybe have a "controller" that knows/ gets the state of the page instead of using these dumb innerHTML hacks?

$(function() {
	$.ajax("/api/v1/profiles", {
		type: "GET",
		success: showProfiles
	});

	$("body").on("click", ".profile", switchProfile);

	// FIXME: the preventDefault isn't really working atm...
	$("#profile_new").submit(function(e) {
		e.preventDefault();

		createProfile($("#profile_new_input").val());
	});

	// TODO: make the edit add text a form instead
});

function showProfiles(profileDict) {
	function appendProfile(profile) {
		var profileHtml = `<div class="profile">${profile}</div>`;
		$("#profile_list").append(profileHtml);
	}

	var profileList = [];
	for (var profile in profileDict) {
		profileList.push(profile);
	}
	profileList.sort().forEach(appendProfile);
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

function switchProfile() {
	$(".selected").removeClass("selected");
	$(this).addClass("selected");

	var profileName = this.innerHTML;
	$.ajax(`/api/v1/profiles/${profileName}`, {
		type: "GET",
		success: function(urlData) {
			$("#profile_download_link").attr("href", urlData.url);
			$("#profile_name").text(profileName);
		}
	})
}

// TODO: update to new version
function deleteProfile() {
	var profileName = $("#profile_delete_name").val();
	$.ajax(`/api/v1/profiles/${profileName}`, {
		type: "DELETE",
		success: function() {
			window.location.reload();
		}
	})
}

function addTextToProfile() {
	var profileName = $("#profile_name").text();
	var data = {text: $("#profile_edit_add_text_input").val()};

	// TODO: make wrapper function for this
	$.ajax(`/api/v1/dict/add/${profileName}`, {
		type: "PUT",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function() {
			alert("done!");
		}
	})
}