module QualifiersHelper
  def twitterized_qualifier_class(type, options = {})
    prefix       = 'text'
    element_type = options.delete(:element_type)

    if element_type and element_type.to_s == 'label'
      prefix = 'label'
    end

    case type
      when 'positive'
        "#{prefix}-success"
      when 'neutral'
        "#{prefix}-warning"
      when 'negative'
        (prefix == 'label') ? "label-important" : "text-error"
      else
        type.to_s
    end
  end
end
