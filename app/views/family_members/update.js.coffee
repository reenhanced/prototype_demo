$("#family-member-<%= @family_member.id %>-errors")
  .replaceWith( $('<div id="family-member-<%= @family_member.id %>-errors"><%= escape_javascript( render("shared/error_messages", record: @family_member)) %></div>'))

<% unless @family_member.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-family-members]').click()
$("#family_member_<%= @family_member.id %>_modal").modal('hide')
$("#family-member-<%= @family_member.id %>-row")
  .replaceWith( $('<%= escape_javascript( render("family_members/family_member_row", family_member: @family_member)) %>'))
$("#family-member-<%= @family_member.id %>-row")
  .hide()
  .fadeIn('slow')
<% end %>
