module Components::ButtonHelper

  def render_primary_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    button_classes = "rounded bg-primary-600 text-sm font-semibold text-white shadow-sm hover:bg-primary-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary-600"
    variant_classes = case variant.to_sym
    when :lg
      "px-2.5 py-1.5"
    when :sm
      "px-2 py-1 text-xs"
    when :md
      "rounded-md px-2 py-1"
    when :xl
      "rounded-md px-3 py-2"
    when :xxl
      "rounded-md px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end

  def render_secondary_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    button_classes = "rounded bg-white px-2 py-1 text-xs font-semibold text-secondary-900 shadow-sm ring-1 ring-inset ring-secondary-300 hover:bg-secondary-50"
    variant_classes = case variant.to_sym
    when :lg
      "px-2.5 py-1.5"
    when :sm
      "px-2 py-1 text-xs"
    when :md
      "rounded-md px-2 py-1"
    when :xl
      "rounded-md px-3 py-2"
    when :xxl
      "rounded-md px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end

  def render_primary_rounded_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    button_classes = "rounded-full bg-primary-600 text-xs font-semibold text-white shadow-sm hover:bg-primary-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary-600"
    variant_classes = case variant.to_sym
    when :lg
      "px-2.5 py-1.5"
    when :sm
      "px-2 py-1 text-xs"
    when :md
      "px-2 py-1"
    when :xl
      "px-3 py-2"
    when :xxl
      "px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end

  def render_secondary_rounded_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    button_classes = "rounded-full bg-secondary-600 text-xs font-semibold text-white shadow-sm hover:bg-secondary-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-secondary-600"
    variant_classes = case variant.to_sym
    when :lg
      "px-2.5 py-1.5"
    when :sm
      "px-2 py-1 text-xs"
    when :md
      "px-2 py-1"
    when :xl
      "px-3 py-2"
    when :xxl
      "px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end

  def render_primary_leading_icon_button(label = "", text: nil, variant: :lg, as: :button, href: nil, data: {}, **options, &block)
    optional = {}
    button_classes = "inline-flex items-center gap-x-1.5 rounded-md bg-indigo-600 px-2.5 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
    variant_classes = case variant.to_sym
    when :lg
      "px-2.5 py-1.5"
    when :sm
      "px-2 py-1 text-xs"
    when :md
      "px-2 py-1"
    when :xl
      "px-3 py-2"
    when :xxl
      "px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    optional[:label] = label
    render "components/ui/button", text:, button_classes:, as:, href:, data:, optional:, **options
  end  
end
