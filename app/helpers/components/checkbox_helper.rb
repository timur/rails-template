module Components::CheckboxHelper
  def render_check_box(name:, id:, value:, label:, checkbox_value:, **options)
    base_classes = "h-4 w-4 rounded border-gray-300 text-primary-600 focus:ring-primary-600"
    input_classes = tw(base_classes, options[:class])
    partial = "components/ui/check_box"
    partial = "components/ui/check_box_array" if options[:array]
    Rails.logger.info "name #{name} value: #{value} checkbox_value #{checkbox_value} checked: #{value === checkbox_value}"
    options.reverse_merge!(
      required: (options[:required] || false),
      disabled: (options[:disabled] || false),
      hint: (options[:hint] || ""),
    )
    render partial: "components/ui/check_box", locals: {
      name:,
      value:,
      id:,
      label:,
      input_classes:,
      checked: value === checkbox_value,
      checkbox_value:,
      options: options
    }
  end
end