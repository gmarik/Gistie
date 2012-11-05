module ApplicationHelper
  def font_awesome_icon(class_name, text = '')
    %Q[<i class="icon-#{class_name}"></i> #{text}].html_safe
  end

  alias_method :i, :font_awesome_icon

  def public_clone_url(gist)
    hostname = if defined?(HOSTNAME) then HOSTNAME else request.host end
    "git@#{hostname}:#{gist.id}.git"
  end
end
