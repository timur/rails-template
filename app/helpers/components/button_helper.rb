module Components::ButtonHelper
  def render_primary_button(label = "", text: nil, variant: :default, as: :button, href: nil, data: {}, **options, &block)
    button_classes = "rounded bg-primary-600 text-sm font-semibold text-white shadow-sm hover:bg-primary-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary-600"
    variant_classes = case variant.to_sym
    when :default
      "px-2.5 py-1.5"
    when :large
      "px-3 py-2"
    when :xlarge
      "px-3.5 py-2.5"
    end
    button_classes = tw(button_classes, variant_classes, options[:class])

    text = label if label.present?
    text = capture(&block) if block
    render "components/ui/button", text:, button_classes:, as:, href:, data:, **options
  end
end



