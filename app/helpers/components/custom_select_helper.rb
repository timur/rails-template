module Components::CustomSelectHelper
  def render_custom_select(name:, id: nil, value: nil, entries: [], **options)
    button_classes = "relative w-full cursor-default rounded-md bg-white py-1.5 pl-3 pr-10 text-left text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:outline-none focus:ring-2 focus:ring-primary-600 sm:text-sm sm:leading-6"
    classes = tw(button_classes, options[:class])

    options.reverse_merge!(
      label: (options[:label] || false),
      required: (options[:required] || false),
      disabled: (options[:disabled] || false),
      readonly: (options[:readonly] || false),
      hint: (options[:hint] || ""),
      srlabel: (options[:srlabel] || ""),
      prompt: (options[:prompt] || ""),
    )

    selected_value = entries.find { |e| e[:value] === value  }
    render partial: "components/ui/custom_select", locals: {
      name:,
      id:,
      value: selected_value,
      entries:,
      classes:,
      options: options
    }
  end
end
