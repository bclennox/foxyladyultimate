# encoding: UTF-8
class Layout
  attr_accessor :application_name, :controller, :view_context
  attr_writer :page_title

  def initialize(options = {})
    @application_name = options[:application_name]
    @controller = options[:controller]
    @page_title = options[:page_title]
    @view_context = options[:view_context]
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

  # https://github.com/seyhunak/twitter-bootstrap-rails/blob/56c8d9cb0c4197b8df1cde33d25b4675421a0d9a/app/helpers/bootstrap_flash_helper.rb
  def flash_messages(flash)
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = :success if type == :notice
      type = :error   if type == :alert
      next unless [:error, :info, :success, :warning].include?(type)

      Array(message).each do |msg|
        text = view_context.content_tag(:div,
                           view_context.content_tag(:button, view_context.raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
