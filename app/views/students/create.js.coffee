$('#student-errors')
  .replaceWith( $('<div id="student-errors"><%= escape_javascript( render("shared/error_messages", record: @student)) %></div>'))

<% unless @student.errors.any? %>
$('ul.nav.nav-tabs li a[href=#all-students]').click()
$('<%= escape_javascript( render("students/student_row", student: @student)) %>')
  .prependTo('#all-students table tbody')
  .hide()
  .fadeIn()
$('#new_student input[type=submit]').button('reset')
$('#new_student')[0].reset()
<% end %>
