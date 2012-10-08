$('#call-errors')
  .replaceWith( $('<div id="call-errors"><%= escape_javascript( render("shared/error_messages", record: @call)) %></div>'))

<% unless @call.errors.any? %>

$('<%= escape_javascript( render("call_logs/call_row", call: @call)) %>')
  .prependTo('#all-calls table tbody')
  .hide()
  .fadeIn()

FamilyCard.callLogsUpdated()

<% end %>
