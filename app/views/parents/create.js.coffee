$('#parent-errors')
  .replaceWith( $('<div id="parent-errors"><%= escape_javascript( render("shared/error_messages", record: @parent)) %></div>'))

<% unless @parent.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-parents]').click()
$('<%= escape_javascript( render("parents/parent_row", parent: @parent)) %>')
  .prependTo('#all-parents table tbody')
  .hide()
  .fadeIn()
$('#new_parent input[type=submit]').button('reset')
$('#new_parent')[0].reset()
<% end %>
