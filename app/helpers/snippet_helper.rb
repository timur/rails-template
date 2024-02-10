module SnippetHelper

  def render_snippet(code)
    render partial: "snippet/code", locals: {
      code:
    }
  end

  def formatter
    @formatter ||= Rouge::Formatters::HTML.new
  end

  def lexer
    "Rouge::Lexers::ERB".constantize.new
  rescue
    Rouge::Lexers::PlainText.new
  end

  def formatter_id
    @formatter_id ||= "code-block-#{rand(10_000)}"
  end

  def compact_month_calendar_simple_snippet
    c = <<-CODE
    <%= compact_month_calendar %>
    CODE
    c.strip
  end

  def compact_month_calendar_date_snippet
    c = <<-CODE
    <%= compact_month_calendar(month_date: Date.today + 2.month) %>
    CODE
    c.strip
  end

  def compact_month_calendar_no_navigation_snippet
    c = <<-CODE
    <%= compact_month_calendar(navigation: false) %>
    CODE
    c.strip
  end

  def compact_month_calendar_route_snippet
    c = <<-CODE
    <%= compact_month_calendar(route: "calendar_custom_path") %>
    CODE
    c.strip
  end

  def button_primary_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(size: :sm) %>
<%= button_tag "Button Text", class: button_classes.render(size: :md) %>
<%= button_tag "Button Text", class: button_classes.render(size: :lg) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xl) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xxl) %>
    CODE
    c.strip
  end

  def button_danger_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(size: :sm, color: :danger) %>
<%= button_tag "Button Text", class: button_classes.render(size: :md, color: :danger) %>
<%= button_tag "Button Text", class: button_classes.render(size: :lg, color: :danger) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xl, color: :danger) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xxl, color: :danger) %>
    CODE
    c.strip
  end  
  
  def button_primary_snippet_with_trailing_icon
    c = <<-CODE
    <%= button_tag nil, class: button_classes.render(size: :lg, trailing_icon: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "-ml-0.5 h-4 w-4 text-white" %>
  Button Text LG
<% end %>

<%= button_tag nil, class: button_classes.render(size: :xl, trailing_icon: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "-ml-0.5 h-5 w-5 text-white" %>
  Button Text XL
<% end %>

<%= button_tag nil, class: button_classes.render(size: :xxl, trailing_icon: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "-ml-0.5 h-5 w-5 text-white" %>
  Button Text XXL
<% end %>
    CODE
    c.strip
  end  

  def button_secondary_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(size: :sm, color: :secondary) %>
<%= button_tag "Button Text", class: button_classes.render(size: :md, color: :secondary) %>
<%= button_tag "Button Text", class: button_classes.render(size: :lg, color: :secondary) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xl, color: :secondary) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xxl, color: :secondary) %>
    CODE
    c.strip
  end

  def button_primary_rounded_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(size: :sm, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(size: :md, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(size: :lg, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xl, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(size: :xxl, rounded: true) %>
    CODE
    c.strip
  end 
  
  def button_secondary_rounded_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(secondary: true, size: :sm, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(secondary: true, size: :md, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(secondary: true, size: :lg, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(secondary: true, size: :xl, rounded: true) %>
<%= button_tag "Button Text", class: button_classes.render(secondary: true, size: :xxl, rounded: true) %>
    CODE
    c.strip
  end

  def button_circular_snippet
    c = <<-CODE
    <%= button_tag nil, class: button_classes.render(size: :"sm-rounded", rounded: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "h-5 w-5 text-white" %>
<% end %>
<%= button_tag nil, class: button_classes.render(size: :"md-rounded", rounded: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "h-5 w-5 text-white" %>
<% end %>
<%= button_tag nil, class: button_classes.render(size: :"lg-rounded", rounded: true) do %>
  <%= inline_svg_tag "heroicons-plus.svg", class: "h-5 w-5 text-white" %>
<% end %>
    CODE
    c.strip
  end

  def button_outline_snippet
    c = <<-CODE
    <%= button_tag "Button Text", class: button_classes.render(size: :lg, color: :"outline-red") %>
<%= button_tag "Button Text", class: button_classes.render(size: :lg, color: :"outline-dark-grey") %>   
    CODE
    c.strip
  end  
end


