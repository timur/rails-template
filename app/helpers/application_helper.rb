module ApplicationHelper
  DEFAULT_LINK_CLASSES = %w(text-gray-700 group flex gap-x-3 rounded-md p-2 text-sm leading-6 font-semibold hover:text-primary-600 hover:bg-gray-50)
  DEFAULT_LINK_CLASSES_PLAIN = %w(text-gray-700 group flex gap-x-3 rounded-md text-sm leading-6 font-semibold hover:text-primary-600 hover:bg-gray-50)

  DEFAULT_STANDARD_LINK_CLASSES = %w(font-semibold text-primary-600 hover:text-primary-500)

  include Pagy::Frontend

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

  def nav_link_button(text:, **options)
    classes = DEFAULT_LINK_CLASSES_PLAIN
    
    render partial: "shared/nav_link_button_template", locals: {
      text:,
      classes:,
      options:
    }
  end  

  def nav_link_with_submenu(name:, text:, **options)
    current_path = false
    classes = DEFAULT_LINK_CLASSES
    submenu = options[:submenu]
    entry = submenu.find { |s| current_page?(s.url) }
    if entry
      current_path = true
    end 
    
    render partial: "shared/nav_link_submenu", locals: {
      name:,
      text:,
      classes:,
      current_path:,
      submenu: options[:submenu],
      options:
    }    
  end

  def is_submenu_link?(submenu)
    return false if submenu.nil?
    submenu.any? { |s| current_page?(s.url) }
  end

  def submenu_link_classes(expanded)
    TailwindClasses.submenu_arrow_classes.render(
      expanded: expanded
    )
  end

  def svg_classes(path)
    current_page?(path) ? "h-6 w-6 text-primary-600" : "h-6 w-6 text-gray-400 group-hover:text-primary-600"
  end

  def svg_classes_plain
    "h-6 w-6 text-gray-400 group-hover:text-primary-600"
  end

  def link_classes
    DEFAULT_STANDARD_LINK_CLASSES
  end

  private

  def current_link(classes)
    elements_to_remove = %w(text-gray-700 hover:text-primary-600 hover:bg-gray-50)
    classes = classes.reject { |class_name| elements_to_remove.include?(class_name) }
    classes << "text-primary-600 bg-gray-50"
    classes.compact.join(" ")
  end

  def sort_link_to_preline(name, column, **options)
    arrow = ''
  
    if params[:sort] == column.to_s
      direction = params[:direction] == "asc" ? "desc" : "asc"
  
      if direction === "asc"
        arrow = content_tag(:span, class: 'text-xs font-semibold uppercase tracking-wide text-gray-800 dark:text-gray-200') do
          inline_svg_tag('down-arrow-preline.svg', class: 'flex-shrink-0 h-3.5 w-3.5')
        end
      end
  
      if direction === "desc"
        arrow = content_tag(:span, class: 'text-xs font-semibold uppercase tracking-wide text-gray-800 dark:text-gray-200') do
          inline_svg_tag('up-arrow-preline.svg', class: 'flex-shrink-0 h-3.5 w-3.5')
        end

      end
    else
      direction = "asc"
    end
  
    link_to request.params.merge(sort: column, direction: direction), class: "group inline-flex justify-center gap-x-2", **options.merge({'data-turbo-prefetch': 'false'}) do
      "#{name} #{arrow}".html_safe
    end
  end

  def sort_link_to(name, column, **options)
    arrow = ''
  
    if params[:sort] == column.to_s
      direction = params[:direction] == "asc" ? "desc" : "asc"
  
      if direction === "asc"
        arrow = content_tag(:span, class: 'ml-2 flex-none rounded bg-gray-200 text-gray-900 group-hover:bg-gray-300') do
          inline_svg_tag('down-arrow.svg', class: 'h-5 w-5')
        end
      end
  
      if direction === "desc"
        arrow = content_tag(:span, class: 'ml-2 flex-none rounded bg-gray-200 text-gray-900 group-hover:bg-gray-300') do
          inline_svg_tag('up-arrow.svg', class: 'h-5 w-5')
        end

      end
    else
      direction = "asc"
    end
  
    link_to request.params.merge(sort: column, direction: direction), **options.merge({'data-turbo-prefetch': 'false'}) do
      "#{name} #{arrow}".html_safe
    end
  end

  def pagy_info_custom(pagy, pagy_id: nil, item_name: nil, i18n_key: nil)
    p_id    = %( id="#{pagy_id}") if pagy_id
    p_count = pagy.count
    key     = if    p_count.zero?   then 'pagy.info.no_items'
              elsif pagy.pages == 1 then 'pagy.info.single_page'
              else                       'pagy.info.multiple_pages' # rubocop:disable Lint/ElseLayout
              end
    "Zeige #{pagy.from}-#{pagy.to} von #{p_count}"
  end

  def gallery_style(width, height)
    "width:#{width.to_f * 200 / height.to_f}px;flex-grow:#{width.to_f * 200 / height.to_f}"
  end

  def i_style(width, height)
    ratio = (height.to_f / width.to_f) * 100
    "padding-bottom:#{ratio}%"
  end

  def link_classes_plain
    DEFAULT_LINK_CLASSES_PLAIN
  end

  def user_avatar_round_small
    imagekit_service = ImagekitService.new
    if Current.user && Current.user.avatar.attached?
      avatar_url = imagekit_service.face_url_small(Current.user.avatar)
      return image_tag Current.user.avatar.url, class: "h-8 w-8 rounded-full bg-gray-50", "data-turbo-permanent": ""
    else
      return inline_svg_tag "heroicons-user-circle-solid.svg", class: "h-8 w-8 bg-gray-100"
    end
  end
end
