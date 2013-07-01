# encoding: UTF-8
class Layout
  attr_accessor :application_name, :controller
  attr_writer :page_title

  def initialize(options = {})
    @application_name = options[:application_name]
    @controller = options[:controller]
    @page_title = options[:page_title]
  end

  def page_title
    if @page_title.present?
      "#{@page_title} — #{application_name}"
    else
      application_name
    end
  end

  def body_class
    [controller.controller_name, controller.action_name].join(' ')
  end
end
