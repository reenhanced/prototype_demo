class @FamilyCard
  @_initializeCallLog: ->
    if(@newCallLog)
      @newCallLog.find('#call_log_contact_id').change(@syncContactIdandContactType)
      @newCallLog.find('[id*=call_log_recorded_at_]').change(@updateCallLogDateAndTime)

  @_initializeStudentAndParentForms: ->
    if(@newStudent)
      @newStudent.find('#use_default_parent').on('click', {modelType: 'student'}, @_copyParentAddressFor)
    if(@newParent)
      @newParent.find('#use_default_parent').on('click', {modelType: 'parent'}, @_copyParentAddressFor)

  @_copyParentAddressFor: (event) ->
    checkbox = this
    modelType = event.data.modelType
    $.each FamilyCard.parentFieldMapFor(modelType), (parent_data_id, model_field_id) ->
      parent_data_element = $(parent_data_id)
      model_field       = $(model_field_id)
      if (checkbox.checked)
        if (parent_data_element)
          model_field.val(parent_data_element.html())
          model_field.prop('disabled', 'disabled')
      else
        if (parent_data_element)
          model_field.val('')
          model_field.prop('disabled', '')

  @parentFieldMapFor: (modelType) ->
      # this maps the id of the parent's data to the input on the new student form
      return {
        'dl.contact dd.email':                          "##{modelType}_email",
        'dl.contact dd.phone':                          "##{modelType}_phone",
        'dl.address dd address.adr .street-address':    "##{modelType}_address1",
        'dl.address dd address.adr .extended-address':  "##{modelType}_address2",
        'dl.address dd address.adr .locality':          "##{modelType}_city",
        'dl.address dd address.adr .postal-code':       "##{modelType}_zip_code"
      }

  @syncContactIdandContactType: ->
    selectedContactType = $('#call_log_contact_id option:selected').attr('data-contact-type')
    $('#call_log_contact_type').val(selectedContactType)

  @updateCallLogDateAndTime: ->
    year   = $('#call_log_recorded_at_1i').val()
    month  = $('#call_log_recorded_at_2i').val()
    day    = $('#call_log_recorded_at_3i').val()
    hour   = $('#call_log_recorded_at_4i').val()
    minute = $('#call_log_recorded_at_5i').val()
    am_pm  = ''

    if hour < 12
      am_pm = 'AM'
    else
      am_pm = 'PM'
      hour = hour - 12 if hour > 12

    datetime = "#{hour}:#{minute}#{am_pm} on #{month}/#{day}/#{year}"

    $('#new_call_log #selected-datetime').html(datetime)

  @init: ->
    this.newStudent  = $('#new_student')
    this.newParent   = $('#new_parent')
    this.newCallLog = $('#new_call_log')
    this._initializeCallLog()
    this._initializeStudentAndParentForms()

  @callLogsUpdated: ->
    $('ul.nav.nav-tabs li a[href=#all-calls]').click()
    @newCallLog.modal('hide')
    @newCallLog.find('input[type=submit]').button('reset')
    @newCallLog[0].reset()

$ ->
  FamilyCard.init()
