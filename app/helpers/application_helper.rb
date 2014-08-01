module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end


  def markdown(text)
    text = '' if text.nil?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end

end
