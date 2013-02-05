# encoding: UTF-8
module LayoutHelper
  def title(t)
    content_for(:title, t.to_s)
  end

  def page_title
    if content_for?(:title)
      "#{content_for(:title)} — #{app_name}"
    else
      app_name
    end
  end

  def app_name
    'Foxy Lady Ultimate'
  end

  def body_class
    [controller.controller_name, controller.action_name].join(' ')
  end
end
