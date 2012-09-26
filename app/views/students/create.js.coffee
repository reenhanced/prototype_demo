$('#student-errors')
  .replaceWith( $('<div id="student-errors"><%= escape_javascript(render(partial: "shared/error_messages", record: @student))%></div>'))
