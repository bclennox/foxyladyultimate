class LocationDecorator < ApplicationDecorator
  def link
    h.link_to name, url, target: :_blank
  end
end
