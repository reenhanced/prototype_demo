class @FamilyCard
  @_initializeCallLog: ->
    if(@newCallLog)
      @newCallLog.find('#call_log_contact_id').change(@syncContactIdandContactType)

  @_initializeStudentForm: ->
    if(@newStudent)
      @newStudent.find('#use_default_parent').click(@_copyParentAddressToStudent)

  @_copyParentAddressToStudent: ->
    checkbox = this
    $.each FamilyCard.parentStudentFieldMap(), (parent_data_id, student_field_id) ->
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

  @parentStudentFieldMap: ->
      # this maps the id of the parent's data to the input on the new student form
      return {
        'dl.contact dd.email':                          '#student_email',
        'dl.contact dd.phone':                          '#student_phone',
        'dl.address dd address.adr .street-address':    '#student_address1',
        'dl.address dd address.adr .extended-address':  '#student_address2',
        'dl.address dd address.adr .locality':          '#student_city',
        'dl.address dd address.adr .postal-code':       '#student_zip_code'
      }

  @syncContactIdandContactType: ->
    selectedContactType = $('#call_log_contact_id option:selected').attr('data-contact-type')
    $('#call_log_contact_type').val(selectedContactType)


  @init: ->
    this.newStudent  = $('#new_student')
    this.newCallLog = $('#new_call_log')
    this._initializeCallLog()
    this._initializeStudentForm()

  @callLogsUpdated: ->
    $('ul.nav.nav-tabs li a[href=#all-calls]').click()
    @newCallLog.modal('hide')
    @newCallLog.find('input[type=submit]').button('reset')
    @newCallLog[0].reset()

$ ->
  FamilyCard.init()
