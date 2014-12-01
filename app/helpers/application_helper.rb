module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end


  def markdown(text)
    text = '' if text.nil?
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(text).html_safe
  end


  def pprn_number_to_human(n)
    number_to_human(n, :format => '%n%u', :units => { :thousand => 'K', :million => "M", :billion => "B", :trillion => "T", :quadrillion => "Q" })
  end



  # DISABLING FOR NOW BUT THIS CODE COULD BE USED BELOW TO STOP THE ROUNDING THAT HAPPENS IN PPRN_NUMBER_TO_HUMAN
  # def number_in_units(n)
  #   # n being the number to be formatted
  #   if (n >= 1000000)
  #     number_in_units_helper(n,1000000,"M")
  #   elsif (n >= 1000)
  #     number_in_units_helper(n,1000,"k")
  #   else
  #     n.to_s
  #   end
  # end

  # def number_in_units_helper(n, unit_value, unit_string)
  #   max_digits = 3
  #   number_divided = n.to_f/unit_value
  #   whole_digits = number_divided.to_s.split(".")[0].size
  #   return ("%.#{max_digits-whole_digits}f" % number_divided) + unit_string
  # end

end
