module ApplicationHelper
  def default_nav_link_classes(link)
    default_classes = "text-gray-700 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold"
    link_class = current_page?(link) ? "text-primary-600 bg-gray-50" : "hover:text-primary-600 hover:bg-gray-50"
    class_names(default_classes, link_class)
  end
end