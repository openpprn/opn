module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end


  def markdown(text)
    text = '' if text.nil?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end


  def number_in_largest_unit(n)
    # n being the number to be formatted
    if (n >= 1000000)
      number_in_units(n,1000000,"M")
    elsif (n >= 1000)
      number_in_units(n,1000,"k")
    else
      n.to_s
    end
  end

  def number_in_units(n, unit_value, unit_string)
    max_digits = 3
    number_divided = n.to_f/unit_value
    whole_digits = number_divided.to_s.split(".")[0].size
    return "%g" % ("%.#{max_digits-whole_digits}f" % number_divided) + unit_string
  end

end
