$ ->
  new_student_form = $('#new_student')
  if(new_student_form)
    # this maps the id of the parent's data to the input on the new student form
    fields_to_update = {
      'dl.contact dd.email':                          '#student_email',
      'dl.contact dd.phone':                          '#student_phone',
      'dl.address dd address.adr .street-address':    '#student_address1',
      'dl.address dd address.adr .extended-address':  '#student_address2',
      'dl.address dd address.adr .locality':          '#student_city',
      'dl.address dd address.adr .postal-code':       '#student_zip_code'
    }

    $('#new_student #use_default_parent').click ->
      checkbox = this
      $.each fields_to_update, (parent_data_id, student_field_id) ->
        parent_data_element = $(parent_data_id)
        student_field       = $(student_field_id)
        if (checkbox.checked)
          if (parent_data_element)
            student_field.val(parent_data_element.html())
            student_field.prop('disabled', 'disabled')
        else
          if (parent_data_element)
            student_field.val('')
            student_field.prop('disabled', '')
