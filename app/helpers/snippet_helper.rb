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
end
