class QuipDecorator < ApplicationDecorator
  def active_icon
    icon('check-circle-fill') if active?
  end

  def edit_link
    h.link_to h.edit_quip_path(self) do
      h.tag.span('Edit', class: 'visually-hidden') + icon(:pencil_fill)
    end
  end
end
