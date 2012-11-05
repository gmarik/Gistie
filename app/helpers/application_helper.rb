module ApplicationHelper
  def font_awesome_icon(class_name, text)
    %Q[<i class="icon-#{class_name}"></i> #{text}].html_safe
  end

  alias_method :i, :font_awesome_icon
end
