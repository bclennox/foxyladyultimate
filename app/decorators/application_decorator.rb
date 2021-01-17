class ApplicationDecorator < Draper::Decorator
  delegate_all

  def icon(name, classes: [])
    h.tag.svg class: (Array.wrap(classes) << 'bi').join(' ') do
      h.tag.use 'xlink:href' => h.asset_path('bootstrap-icons/bootstrap-icons.svg') + "##{name}"
    end
  end
end
