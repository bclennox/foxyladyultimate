class ApplicationDecorator < Draper::Decorator
  delegate_all

  def icon(name, classes: [])
    h.tag.i class: ['bi', "bi-#{name.to_s.dasherize}", *classes].join(' ')
  end
end
