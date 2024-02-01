class Railsbootstrap::FormBuilder < ActionView::Helpers::FormBuilder
  def label(method, options = {})
    error_class = @object.errors[method].any? ? "text-red-500" : ""
    options[:class] = "#{options[:class]} #{error_class}"
    @template.render_label(name: "#{object_name}[#{method}]", label: label_for(@object, method), **options)
  end

  def text_field(method, options = {})
    set_error_attributes(options, method)
    @template.render_input(
      name: "#{object_name}[#{method}]",
      id: "#{object_name}_#{method}",
      value: @object.send(method),
      type: "text", 
      **options
    )
  end

  def money_field(method, options = {})
    set_error_attributes(options, method)
    options[:money] = "$money($input, ',')"
    options[:trailing_text] = options[:trailing_text] || "€"
    options[:leading_text] = options[:leading_text]
    @template.render_input(
      name: "#{object_name}[#{method}]",
      id: "#{object_name}_#{method}",
      value: @object.send(method),
      type: "text",
      template: "components/ui/input_money",
      **options
    )
  end

  def custom_select(method, entries = [], options = {})
    set_error_attributes(options, method)
    @template.render_custom_select(
      name: "#{object_name}[#{method}]",
      id: "#{object_name}_#{method}",
      value: @object.send(method),
      entries: entries,
      **options
    )
  end

  def custom_check_box(method, label, options = {}, checkbox_value = "1")
    set_error_attributes(options, method)
    @template.render_check_box(
      name: "#{object_name}[#{method}]",
      id: "#{object_name}_#{method}",
      value: @object.send(method),
      label: "#{label}",
      checkbox_value: checkbox_value,
      **options
    )
  end

  def datepicker(method, options = {})
    set_error_attributes(options, method)
    @template.render_datepicker(
      name: "#{object_name}[#{method}]",
      id: "#{object_name}_#{method}",
      value: @object.send(method),
      **options
    )
  end

  private

  def label_for(object, method)
    return method.capitalize if object.nil?
    object.class.human_attribute_name(method)
  end

  def error_class_for(method, custom_class = "")
    error_class = has_error?(method) ? "ring-red-300 placeholder:text-red-300 focus:ring-red-500 text-red-500" : ""
    "#{custom_class} #{error_class}"
  end

  def has_error?(method)
    @object.errors[method].any?
  end

  def set_error_attributes(options, method)
    options[:class] = error_class_for(method, options[:class])
    options[:has_error] = has_error?(method)
    options[:errors] = @object.errors[method]
  end
end
