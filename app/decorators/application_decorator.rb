class ApplicationDecorator < Draper::Decorator
  delegate_all

  def icon(name)
    h.tag.svg class: 'bi', fill: 'currentColor' do
      h.tag.use href: h.asset_path("bootstrap-icons/bootstrap-icons.svg##{name.to_s.dasherize}")
    end
  end
end
