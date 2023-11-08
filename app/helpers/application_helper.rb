module ApplicationHelper
  DEFAULT_LINK_CLASSES = %w(text-gray-700 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold hover:text-primary-600 hover:bg-gray-50)

  def nav_link(path:, text:, **options)
    classes = DEFAULT_LINK_CLASSES
    classes = current_page?(path) ? current_link(classes) : classes
    
    render partial: "shared/nav_link_template", locals: {
      path:,
      text:,
      classes:,
      options:
    }
  end

  def nav_link_with_submenu(path:, text:, **options)
    classes = DEFAULT_LINK_CLASSES
    classes = current_page?(path) ? current_link(classes) : classes
    
    render partial: "shared/nav_link_submenu", locals: {
      path:,
      text:,
      classes:,
      submenu: options[:submenu],
      options:
    }    
  end

  def svg_classes(path)
    current_page?(path) ? "h-6 w-6 text-primary-600" : "h-6 w-6 text-gray-400 group-hover:text-primary-600"
  end

  private

  def current_link(classes)
    elements_to_remove = %w(text-gray-700 hover:text-primary-600 hover:bg-gray-50)
    classes = classes.reject { |class_name| elements_to_remove.include?(class_name) }
    classes << "text-primary-600 bg-gray-50"
    classes.compact.join(" ")
  end
end