module ApplicationHelper
  def bootstrap_class(type, options = {})
    prefix = options.delete(:type) || 'text'

    case type.to_s
      when /positive|update/
        "#{prefix}-success"
      when /neutral/
        "#{prefix}-warning"
      when /negative|destroy/
        (prefix.to_s == 'label') ? "label-important" : "text-error"
      when /notice|create/
        "#{prefix}-info"
      when /error/
        "alert-error"
      when /alert/
        "alert-block"
      when /success/
        "alert-success"
      else
        type.to_s
    end
  end

  def address_tag_for(object)
    return "" unless object.respond_to?(:address1) and object.respond_to?(:address2) and
                     object.respond_to?(:city)     and object.respond_to?(:state) and
                     object.respond_to?(:zip_code)

    street_address = content_tag(:span, object.address1, class: 'street-address')
    street_address +=  tag(:br) if object.address1.present?

    secondary_address = ""
    if object.address2.present?
      secondary_address = content_tag(:span, object.address2, class: 'extended-address') + tag(:br)
    end

    city = ""
    if object.city.present?
      city = content_tag(:span, object.city, class: 'locality')
      city += ", " if object.state.present?
    end

    state       = content_tag(:span, object.state, class: 'region')
    postal_code = content_tag(:span, object.zip_code, class: 'postal-code')

    content_tag :address, class: 'adr' do
      street_address + secondary_address + city + state + " " + postal_code
    end

  end
end
