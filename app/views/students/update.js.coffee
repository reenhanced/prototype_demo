$("#student-<%= @student.id %>-errors")
  .replaceWith( $('<div id="student-<%= @student.id %>-errors"><%= escape_javascript( render("shared/error_messages", record: @student)) %></div>'))

<% unless @student.errors.any? %>
$('#edit_student_<%= @student.id %>')
  .collapse('hide')
  .parents('tr').remove()
$("#student-<%= @student.id %>-row")
  .replaceWith( $('<%= escape_javascript( render("students/student_row", student: @student)) %>'))
$("#student-<%= @student.id %>-row")
  .hide()
  .fadeIn('slow')
<% end %>
