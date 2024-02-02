module Components::InputHelper
  def render_input(name:, type: :text, value: nil, template: "components/ui/input", **options)
    options[:class] = "#{InputClasses.input.render} #{(options[:class])}"

    options.reverse_merge!(
      hint: (options[:hint] || ""),
    )
    render partial: template, locals: {
      type:,
      name:,
      value:,
      options: options
    }
  end

  def has_icon? options
    (options[:has_error] || options[:trailing_text] || options[:leading_text])
  end
end
