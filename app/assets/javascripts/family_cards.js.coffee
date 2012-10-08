class @FamilyCard
  @_initialize_call_log: ->
    if(this.new_call_log)
      $('#new_call_log #call_log_contact_id').change ->
        selected_contact_type = $('#call_log_contact_id option:selected').attr('data-contact-type')
        $('#call_log_contact_type').val(selected_contact_type)

  @_initialize_student_form: ->
    if(this.new_student)
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

  @init: ->
    this.new_student  = $('#new_student')
    this.new_call_log = $('#new_call_log')
    this._initialize_call_log()
    this._initialize_student_form()

  @update_call_logs: ->
    $('ul.nav.nav-tabs li a[href=#all-calls]').click()
    $('#new_call_log').modal('hide')
    $('#new_call_log input[type=submit]').button('reset')
    $('#new_call_log')[0].reset()

$ ->
  FamilyCard.init()
