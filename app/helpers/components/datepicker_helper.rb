module Components::DatepickerHelper
  def render_datepicker(name:, id: nil, value: nil, template: "components/ui/datepicker", **options)
    base_classes = "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary-600 sm:text-sm sm:leading-6 pr-10"
    input_classes = "#{base_classes} #{options[:class]}"
    container_classes = "relative rounded-md shadow-sm"
    type = "text"

    options.reverse_merge!(
      required: (options[:required] || false),
      disabled: (options[:disabled] || false),
      readonly: (options[:readonly] || false),
      placeholder: (options[:placeholder] || ""),
      hint: (options[:hint] || ""),
      width_class: (options[:width_class] || "")
    )
    render partial: template, locals: {
      name:,
      value:,
      id:,
      type:,
      input_classes:,
      container_classes:,
      options: options
    }
  end
end
