module TailwindClasses
  class << self
    # renders a calendar cell classes for a compact month calendar
    def calendar_cell
      ClassVariants.build(
        "py-1.5 hover:bg-gray-100 focus:z-10",
        variants: {
          in_current_month: "bg-white text-gray-900",
          "!in_current_month": "bg-gray-50 text-gray-400",
          is_first_in_month_range: "rounded-tl-lg",
          is_last_in_month_range: "rounded-br-lg",
          is_last_day_of_first_week: "rounded-tr-lg",
          is_first_day_of_last_week: "rounded-bl-lg",
        },
        defaults: {
          in_current_month: true
        }
      )   
    end

    # renders a circle in a calendar cell for a compact month calendar
    def calendar_cell_inside
      ClassVariants.build(
        "mx-auto flex h-7 w-7 items-center justify-center rounded-full",
        variants: {
          today: "bg-indigo-600 font-semibold text-white"
        }
      )   
    end
    
    def calendar_cell_inside_events
      ClassVariants.build(
        "mx-auto flex h-7 w-7 items-center justify-center rounded-full",
        variants: {
          event: "font-semibold text-white"
        }
      )   
    end      
  end
end
