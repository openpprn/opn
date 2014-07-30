# Issue #8 - Admins and Owners
$(document).on "click", "#admin-dashboard .add-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#admin-dashboard #role-id").data("authenticity-token")
  user_id = $(this).closest(".user").data("user-id")
  role_id = $("#admin-dashboard #role-id").val()
  target_path = $("#admin-dashboard #role-id").data("add-target")

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role_id: role_id
  })

$(document).on "click", "#admin-dashboard .remove-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#admin-dashboard #role-id").data("authenticity-token")
  user_id = $(this).closest(".user").data("user-id")
  role_id = $(this).data("role-id")
  target_path = $("#admin-dashboard #role-id").data("remove-target")

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role_id: role_id
  })