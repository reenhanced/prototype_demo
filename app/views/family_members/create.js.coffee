$('#family-member-errors')
  .replaceWith( $('<div id="family-member-errors"><%= escape_javascript( render("shared/error_messages", record: @family_member)) %></div>'))

<% unless @family_member.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-family-members]').click()
$('<%= escape_javascript( render("family_members/family_member_row", family_member: @family_member)) %>')
  .prependTo('#all-family-members table tbody')
  .hide()
  .fadeIn()
$('#new_family_member input[type=submit]').button('reset')
$('#new_family_member')[0].reset()
<% end %>
