module PersonHelper

  def person_status(status)
    case status
    when "successfull"
      person_status_badge_success(status)
    when "warning"
      person_status_badge_warning(status)
    when "danger"
      person_status_badge_danger(status)      
    else
      person_status_badge_success(status)
    end
  end

  def person_status_badge_success(status)
    tag.span(class: "py-1 px-1.5 inline-flex items-center gap-x-1 text-xs font-medium bg-teal-100 text-teal-800 rounded-full dark:bg-teal-500/10 dark:text-teal-500") do
      concat(inline_svg_tag('heroicons-check-circle-solid.svg', class: 'w-3 h-3'))
      concat(tag.span(status.capitalize))
    end
  end

  def person_status_badge_warning(status)
    tag.span(class: "py-1 px-1.5 inline-flex items-center gap-x-1 text-xs font-medium bg-yellow-100 text-yellow-800 rounded-full dark:bg-yellow-500/10 dark:text-yellow-500") do
      concat(inline_svg_tag('heroicons-exclamation-triangle-solid.svg', class: 'w-3 h-3'))
      concat(tag.span(status.capitalize))
    end
  end  

  def person_status_badge_danger(status)
    tag.span(class: "py-1 px-1.5 inline-flex items-center gap-x-1 text-xs font-medium bg-red-100 text-red-800 rounded-full dark:bg-red-500/10 dark:text-red-500") do
      concat(inline_svg_tag('heroicons-exclamation-triangle-solid.svg', class: 'w-3 h-3'))
      concat(tag.span(status.capitalize))
    end
  end    
end