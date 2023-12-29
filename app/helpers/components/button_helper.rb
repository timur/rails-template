module Components::ButtonHelper
  def render_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, button_classes: "", **options, &block)
    base_classes = "rounded text-xs font-semibold text-white shadow-sm hover:bg-{{bg}} focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-{{bg}}"
    
    variant_classes = case variant.to_sym
    when :sm
      "px-2 py-1"
    when :md
      "px-2 py-1 text-sm"
    when :lg
      "px-2.5 py-1.5 text-sm"
    when :xl
      "px-3 py-2 text-sm"
    when :xxl
      "px-3.5 py-2.5 text-sm"
    when :"sm-rounded"
      "p-1"
    when :"md-rounded"
      "p-1.5"
    when :"lg-rounded"
      "p-2"
    end

    base_classes_with_color = base_classes.sub("{{bg}}", "{{color}}")
    hover_classes = base_classes.sub("{{bg}}", "{{hover_color}}")

    button_classes = "#{base_classes_with_color} #{variant_classes} #{options[:class]} #{button_classes}"
    hover_classes = "#{hover_classes} #{variant_classes} #{options[:class]} #{button_classes}"

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end

  def render_primary_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "rounded bg-primary-600 hover:bg-primary-500", **options, &block)
  end

  def render_secondary_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "rounded bg-white text-xs font-semibold text-secondary-900 shadow-sm ring-1 ring-inset ring-secondary-300 hover:bg-secondary-50", **options, &block)
  end

  def render_primary_rounded_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "rounded-full bg-primary-600 hover:bg-primary-500 text-xs font-semibold text-white shadow-sm", **options, &block)
  end

  def render_secondary_rounded_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    render_button(label, text: text, variant:, as:, href:, data:, button_classes: "rounded-full bg-secondary-600 text-xs font-semibold text-white shadow-sm hover:bg-secondary-500", **options, &block)
  end

  def render_primary_leading_icon_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    optional = {}
    optional[:label] = label
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "inline-flex items-center gap-x-1.5 rounded-md bg-primary-600 hover:bg-primary-500", optional:, **options, &block)
  end

  def render_primary_trailing_icon_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    optional = {}
    optional[:label] = label
    optional[:trailing] = true
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "inline-flex items-center gap-x-1.5 rounded-md bg-primary-600 hover:bg-primary-500", optional:, **options, &block)
  end
  
  def render_circular_icon_button(label = "", text: nil, variant: :"sm-rounded", as: :button, href: nil, data: {}, **options, &block)
    optional = {}
    optional[:rounded] = true
    render_button(label, text:, variant:, as:, href:, data:, button_classes: "rounded-full bg-primary-600 text-white shadow-sm hover:bg-primary-500 focus-visible:outline-offset-2 focus-visible:outline-primary-600", optional:, **options, &block)
  end   
end
