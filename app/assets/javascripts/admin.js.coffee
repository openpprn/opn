# Issue #8 - Admins and Owners
$(document).on "click", "#admin-dashboard .add-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#auth-token").val()
  user_id = $(this).closest(".user").data("user-id")
  role = $(this).data('role')
  target_path = $("#admin-dashboard #role").data("add-target")

#  console.log(target_path)
#  console.log(authenticity_token)
#  console.log(user_id)
#  console.log(role)

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role: role
  })

$(document).on "click", "#admin-dashboard .delete-user", (event) ->
  event.preventDefault()
  authenticity_token = $("#auth-token").val()
  user_id = $(this).closest(".user").data("user-id")
  target_path = $("#admin-dashboard #role").data("destroy-target")

#  console.log(target_path)
#  console.log(authenticity_token)
#  console.log(user_id)


  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id
  })

$(document).on "click", "#admin-dashboard .remove-role", (event) ->
  event.preventDefault()
  authenticity_token = $("#auth-token").val()
  user_id = $(this).closest(".user").data("user-id")
  role = $(this).data("role")
  target_path = $("#admin-dashboard #role").data("remove-target")

#  console.log(target_path)
#  console.log(authenticity_token)
#  console.log(user_id)
#  console.log(role)

  $.post(target_path, {
    authenticity_token: authenticity_token,
    user_id: user_id,
    role: role
  })

$(document).on 'change', "input:radio[name='search_role']", (event) ->
  $("#user-search").submit()

$(document).on "submit", "#admin-dashboard #user-search", (event) ->
  $.post($(this).attr("action")+'.js', $(this).serialize())
  event.preventDefault()
