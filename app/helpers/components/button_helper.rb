module Components::ButtonHelper

  def button_classes(classes = "", **options)
    class_variants("rounded font-semibold shadow-sm focus-visible:outline cursor-hand focus-visible:outline-2 focus-visible:outline-offset-2 disabled:cursor-not-allowed disabled:opacity-50 #{classes}",
      variants: {
        size: {
          sm: "px-2 py-1 text-xs gap-x-1",
          md: "px-2 py-1 text-sm gap-x-1",
          lg: "px-2.5 py-1.5 text-sm gap-x-1",
          xl: "px-3 py-2 text-sm gap-x-1.5",
          xxl: "px-3.5 py-2.5 text-sm gap-x-1.5",
          "sm-rounded": "p-1",
          "md-rounded": "p-1.5",
          "lg-rounded": "p-2",
        },
        color: {
          primary: "bg-primary-600 hover:bg-primary-500 text-white focus-visible:outline-primary-600",
          danger: "bg-red-600 hover:bg-red-500 text-white focus-visible:outline-red-600",
          secondary: "bg-white font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:outline-gray-600",
          "outline-dark-gray": "bg-white border border-gray-800 text-gray-800 hover:border-gray-500 hover:text-gray-500",
          "outline-red": "bg-white border border-red-600 text-red-600 hover:border-red-400 hover:text-red-500",
        },
        trailing_icon: "inline-flex items-center",
        rounded: "rounded-full",
      },
      defaults: {
        size: :md,
        color: :primary
      },
    )
  end
end
