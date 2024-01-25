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
    <%= compact_month_calendar(date: Date.today + 2.month) %>
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
end
