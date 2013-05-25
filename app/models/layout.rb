# encoding: UTF-8
class Layout
  attr_writer :page_title

  def self.application_name
    'Foxy Lady Ultimate'
  end

  def page_title
    if defined?(@page_title)
      "#{@page_title} — #{self.class.application_name}"
    else
      self.class.application_name
    end
  end

  def body_class(controller)
    [controller.controller_name, controller.action_name].join(' ')
  end
end
