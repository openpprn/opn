# Issue #8 - Admins and Owners
$(document).on "click", "#admin-dashboard .add-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#admin-dashboard #role").data("authenticity-token")
  user_id = $(this).closest(".user").data("user-id")
  role = $("#admin-dashboard #role").val()
  target_path = $("#admin-dashboard #role").data("add-target")

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role: role
  })

$(document).on "click", "#admin-dashboard .remove-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#admin-dashboard #role").data("authenticity-token")
  user_id = $(this).closest(".user").data("user-id")
  role = $(this).data("role")
  target_path = $("#admin-dashboard #role").data("remove-target")

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role: role
  })