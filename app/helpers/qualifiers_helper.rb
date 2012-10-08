module QualifiersHelper
  def twitterized_qualifier_class(type, options = {})
    case type
      when 'positive'
        "text-success"
      when 'neutral'
        "text-warning"
      when 'negative'
        "text-error"
      else
        type.to_s
    end
  end
end
