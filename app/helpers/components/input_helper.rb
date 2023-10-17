module Components::InputHelper
  def render_input(name:, label: false, id: nil, type: :text, value: nil, width_class: nil, template: "components/ui/input", **options)
    base_classes = "block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-primary-600 sm:text-sm sm:leading-6"
    input_classes = tw(base_classes, options[:class])
    base_container_classes = "mt-2"
    container_icon_classes = "relative rounded-md shadow-sm"
    container_classes = tw(base_container_classes, has_icon?(options) ? container_icon_classes : "", width_class)

    options.reverse_merge!(
      label: (options[:label] || false),
      required: (options[:required] || false),
      disabled: (options[:disabled] || false),
      readonly: (options[:readonly] || false),
      placeholder: (options[:placeholder] || ""),
      autocomplete: (options[:autocomplete] || ""),
      autocapitalize: (options[:autocapitalize] || nil),
      autocorrect: (options[:autocorrect] || nil),
      autofocus: (options[:autofocus] || nil),
      hint: (options[:hint] || ""),
      width_class: (options[:width_class] || ""),
    )
    render partial: template, locals: {
      type:,
      label:,
      name:,
      value:,
      id:,
      input_classes:,
      container_classes:,
      options: options
    }
  end


  private

  def has_icon? options
    (options[:has_error] || options[:trailing_text] || options[:leading_text])
  end
end
