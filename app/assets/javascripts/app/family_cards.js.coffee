class @FamilyCard
  @active: -> @newStudent()? && @newFamilyMember()?

  @newStudent: -> $('#new_student')
  @newFamilyMember: -> $('#new_family_member')

  @parentFieldMapFor: (modelType) ->
    # this maps the id of the parent's data to the input on the new student form
    {
      'dl.contact dd.email':                          "##{modelType}_email",
      'dl.contact dd.phone':                          "##{modelType}_phone",
      'dl.address dd address.adr .street-address':    "##{modelType}_address1",
      'dl.address dd address.adr .extended-address':  "##{modelType}_address2",
      'dl.address dd address.adr .locality':          "##{modelType}_city",
      'dl.address dd address.adr .postal-code':       "##{modelType}_zip_code"
    }

  constructor: ->
    @student      ?= FamilyCard.newStudent()
    @familyMember ?= FamilyCard.newFamilyMember()

    @_initializeForms()
    @_initializeCancelCollapse()

    @callLog = new CallLog(@)

  _initializeForms: ->
    @student.find('#use_default_parent').on('click',
      {
        modelType: 'student',
        form: @student
      },
      @_copyParentAddressFor)

    @familyMember.find('#use_default_family_member').on('click',
      {
        modelType: 'family_member',
        form: @familyMember
      },
      @_copyParentAddressFor)

  _initializeCancelCollapse: ->
    cancelButtons = $('.btn.cancel-and-collapse')
    if cancelButtons
      cancelButtons.live 'click', ->
        $(this).parents('div.collapse').collapse('hide')

  _copyParentAddressFor: (event) ->
    modelType = event.data.modelType
    form      = event.data.form

    $.each FamilyCard.parentFieldMapFor(modelType), (parent_data_id, model_field_id) =>
      parent_data_element = $(parent_data_id)
      model_field         = form.find(model_field_id)
      if (@checked)
        if (parent_data_element)
          model_field.val(parent_data_element.html())
          model_field.prop('disabled', 'disabled')
      else
        if (parent_data_element)
          model_field.val('')
          model_field.prop('disabled', '')

  prependCallLog: (call_row_html) ->
    $(call_row_html).prependTo('#all-calls table tbody').hide().fadeIn()

  updateQualifiers: (qualifiers) ->
    # update the family card's displayed qualifiers
    $('.family_card .qualifiers').html(qualifiers.html)

$ ->
  if FamilyCard.active()
    new FamilyCard
