module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Baby sleep app'

    if page_title.empty?
      base_title
    else
      page_title + ' – ' + base_title
    end
  end

  def flash_class(level)
    case level
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error then "alert-warning"
    when :alert then "alert-danger"
    end
  end
end
