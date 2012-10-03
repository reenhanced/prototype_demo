module Syncable
  def self.sync(field, options)
    options.asset_valid_keys(:to, :from, :field_name)
    raise ArgumentError, "Cannot combine keys :to and :from" if options.keys.include?(:to) && options.keys.include?(:from)

    field_name = options[:field_name] || field

    if options[:to].present?
      receiver = options[:to]

      define_method(:"#{field}=") do |value|
        self.send(receiver).send(:"#{field_name}=", value)
        self.write_attribute(field, value)
      end
    end
  end
end
