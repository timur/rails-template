module Components::CheckboxHelper
  def render_check_box(name:, id:, value:, label:, checkbox_value:, **options)
    partial = "components/ui/check_box"
    partial = "components/ui/check_box_array" if options[:array]
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
      checked: value === checkbox_value,
      checkbox_value:,
      options: options
    }
  end
end