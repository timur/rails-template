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

    # renders a calendar cell classes for a big month calendar
    def calendar_cell_month
      ClassVariants.build(
        "relative py-2 px-3",
        variants: {
          in_current_month: "bg-white",
          "!in_current_month": "bg-gray-50 text-gray-500",
          today: "flex h-6 w-6 items-center justify-center rounded-full bg-indigo-600 font-semibold text-white"
        },
        defaults: {
          in_current_month: true
        }
      )   
    end  
    
    # renders a calendar time classes for a big month calendar
    def calendar_time_month
      ClassVariants.build(
        "",
        variants: {
          today: "flex h-6 w-6 items-center justify-center rounded-full bg-indigo-600 font-semibold text-white"
        }
      )   
    end
    
    # renders the header of a calendar week
    def calendar_week_header
      ClassVariants.build(
        "items-center justify-center font-semibold text-gray-900",
        variants: {
          today: "ml-1.5 flex h-8 w-8 items-center justify-center rounded-full bg-indigo-600 font-semibold text-white"
        }
      )   
    end
    
    def calendar_week_header_span
      ClassVariants.build(
        "",
        variants: {
          today: "flex items-baseline"
        }
      )   
    end    
  end
end
