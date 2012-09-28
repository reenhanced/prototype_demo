$('#student-errors')
  .replaceWith( $('<div id="student-errors"><%= escape_javascript( render(partial: "shared/error_messages", locals: {record: @student})) %></div>'))

<% unless @student.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-students]').click()
$('<%= escape_javascript( render(partial: "students/student_row", locals: {student: @student})) %>')
  .appendTo('#all-students table tbody')
  .hide()
  .fadeIn()
$('#new_student')[0].reset()
<% end %>
