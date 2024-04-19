module PeopleHelper
  def render_active_status(active)
    content_tag(:span, class: active ? 'text-success' : 'text-danger') do
      content_tag(:i, '', class: "bi bi-#{active ? 'check-circle' : 'x-circle'}")
    end
  end
end
