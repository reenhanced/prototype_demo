$('#call-errors')
  .replaceWith( $('<div id="call-errors"><%= escape_javascript( render("shared/error_messages", record: @call)) %></div>'))

<% unless @call.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-calls]').click()
$('<%= escape_javascript( render("call_logs/call_row", call: @call)) %>')
  .prependTo('#all-calls table tbody')
  .hide()
  .fadeIn()
$('#new_call_log').modal('hide')
$('#new_call_log input[type=submit]').button('reset')
$('#new_call_log')[0].reset()
<% end %>
