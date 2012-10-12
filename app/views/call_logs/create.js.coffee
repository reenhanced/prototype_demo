$('#call-errors')
  .replaceWith( $('<div id="call-errors"><%= escape_javascript( render("shared/error_messages", record: @call_log)) %></div>'))

<% unless @call_log.errors.any? %>

$('<%= escape_javascript( render("call_logs/call_row", call_log: @call_log)) %>')
  .prependTo('#all-calls table tbody')
  .hide()
  .fadeIn()

FamilyCard.callLogsUpdated()

<% end %>
