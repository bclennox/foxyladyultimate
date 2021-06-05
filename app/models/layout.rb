class Layout
  include ActiveModel::Model
  attr_accessor :application_name, :controller, :page_title, :view_context

  def full_page_title
    if page_title.present?
      "#{page_title} — #{application_name}"
    else
      application_name
    end
  end

  def body_class
    [controller.controller_name, controller.action_name].join(' ')
  end

  def nav_link(text, url, options = {})
    active = view_context.current_page?(url) && 'active'

    view_context.tag.li(class: ['nav-item', active].compact.join(' ')) do
      view_context.link_to text, url, options.merge(class: 'nav-link')
    end
  end

  def quips_link
    count = Quip.pending.count
    content = if view_context.authorizer.admin? && count.positive?
      badge = view_context.tag.span(count, class: 'badge badge-info align-middle')
      sr = view_context.tag.span('to review', class: 'sr-only')
      view_context.safe_join(['Quips', badge, sr], ' ')
    else
      'Quips'
    end

    nav_link content, view_context.quips_path
  end

  def flash_messages
    view_context.flash
      .map { AlertComponent.new(type: _1, message: _2) }
      .reject(&:blank?)
      .map { view_context.render(_1) }
      .then { view_context.safe_join(_1) }
  end
end
