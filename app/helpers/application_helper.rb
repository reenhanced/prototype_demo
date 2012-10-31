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

  def address_tag_for(object, options = {})
    prefix = options[:prefix]
    address_attributes = {
      address1: :address1,
      address2: :address2,
      city: :city,
      state: :state,
      zip_code: :zip_code
    }
    if prefix
      address_attributes.each do |attribute_key, attribute|
        address_attributes[attribute_key] = "#{prefix}_#{attribute}".to_sym
      end
    end

    address_attributes.each do |key, value|
      return "" unless object.respond_to?(address_attributes[key])
    end

    street_address = content_tag(:span, object.send(address_attributes[:address1]), class: 'street-address')
    street_address +=  tag(:br) if object.send(address_attributes[:address1]).present?

    secondary_address = ""
    if object.send(address_attributes[:address2]).present?
      secondary_address = content_tag(:span, object.send(address_attributes[:address2]), class: 'extended-address') + tag(:br)
    end

    city = ""
    if object.send(address_attributes[:city]).present?
      city = content_tag(:span, object.send(address_attributes[:city]), class: 'locality')
      city += ", " if object.send(address_attributes[:state]).present?
    end

    state       = content_tag(:span, object.send(address_attributes[:state]), class: 'region')
    postal_code = content_tag(:span, object.send(address_attributes[:zip_code]), class: 'postal-code')

    content_tag :address, class: 'adr' do
      street_address + secondary_address + city + state + " " + postal_code
    end

  end
end
