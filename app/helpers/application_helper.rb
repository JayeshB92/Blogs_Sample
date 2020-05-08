module ApplicationHelper
  def custom_errors_for(object)
    if object.errors.any?
      content_tag(:div, class: "card border-danger") do
        concat(content_tag(:div, class: "card-header bg-danger text-white") do
          concat "#{pluralize(object.errors.count, "error")} prohibited this #{object.class.name.downcase} from being saved:"
        end)
        concat(content_tag(:div, class: "card-body") do
          concat(content_tag(:ul, class: 'mb-0') do
            object.errors.full_messages.each do |msg|
              concat content_tag(:li, msg)
            end
          end)
        end)
      end
    end
  end

  def owner?(object)
    return false unless object.present?
    current_user == object.user
  end
end
