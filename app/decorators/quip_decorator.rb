class QuipDecorator < ApplicationDecorator
  def approval_icon
    if approved.nil?
      icon('question-circle-fill', classes: 'text-info')
    elsif approved
      icon('check-circle-fill', classes: 'text-success')
    else
      icon('x-circle-fill', classes: 'text-danger')
    end
  end

  def edit_link
    h.link_to h.edit_quip_path(object) do
      h.tag.span('Edit', class: 'sr-only') + icon('pencil-fill')
    end
  end

  def player_name
    player.name
  end
end
