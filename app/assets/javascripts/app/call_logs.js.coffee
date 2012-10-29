class @CallLog
  constructor: (@familyCard, @callLog) ->
    @callLog ?= $('#new_call_log')

    if @callLog
      @callLog.find('#call_log_contact_id').change(@syncContactIdandContactType)
      @callLog.find('[id*=call_log_recorded_at_]').change(@updateCallLogDateAndTime)

      @callLog.bind
        'ajax:beforeSend': =>
          $('#call-errors').html('')
          @callLog.spin()
        'ajax:error': (event, xhr) =>
          $('#call-errors').html(xhr.responseText)
        'ajax:success': (event, html) =>
          json = JSON.parse(html)
          @familyCard.prependCallLog(json.call_row)
          $('ul.nav.nav-tabs li a[href=#all-calls]').click()
          @callLog.modal('hide')
          @callLog.find('input[type=submit]').button('reset')
          @callLog[0].reset()
          @familyCard.updateQualifiers(json.qualifiers)
          @updateQualifierCheckboxes(json.qualifiers)
        'ajax:complete': =>
          @callLog.spin(false)

  syncContactIdandContactType: ->
    selectedContactType = $('#call_log_contact_id option:selected').attr('data-contact-type')
    $('#call_log_contact_type').val(selectedContactType)

  updateCallLogDateAndTime: =>
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

    @callLog.find('#selected-datetime').html(datetime)

  updateQualifierCheckboxes: (qualifiers) ->
    # reset checked qualifiers on the new call log form
    $('#new_call_log input[id*=qualifier_ids_]').attr('checked', false)
    $.each qualifiers.ids, (index, qualifier_id) =>
      $("#qualifier_ids_#{qualifier_id}").attr('checked', true)
