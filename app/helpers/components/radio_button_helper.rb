module Components::RadioButtonHelper
  def render_radio_button(name:, id:, value:, label:, radio_value:, **options)
    base_classes = "h-4 w-4 border-gray-300 text-primary-600 focus:ring-primary-600"
    input_classes = "#{base_classes} #{options[:class]}"
    options.reverse_merge!(
      required: (options[:required] || false),
      disabled: (options[:disabled] || false),
      hint: (options[:hint] || ""),
    )
    render partial: "components/ui/radio_button", locals: {
      name:,
      value:,
      id:,
      label:,
      input_classes:,
      checked: value === radio_value,
      radio_value:,
      options: options
    }
  end
end