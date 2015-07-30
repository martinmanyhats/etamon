module ApplicationHelper
  
  def title(page_title)
    if defined?(@boiler)
      page_title = "#{@boiler.shortname} #{page_title}"
    end
    content_for :title, page_title.to_s
  end

end
