module ApplicationHelper
  def nav_link_to(name, path, options = {})
    active_class = "font-medium !text-black"
    default_class = "text-gray-500"
    classes = current_page?(path) ? "#{default_class} #{active_class}" : default_class
    link_to(name, path, options.merge(class: classes))
  end
end
