class AlertComponent < ViewComponent::Base
  delegate :blank?, to: :message

  def initialize(type: , message: )
    @type = type.to_s
    @message = message
  end

  private

  attr_reader :type, :message

  def css_class
    case type
      when 'notice' then 'success'
      when 'alert'  then 'danger'
      else type
    end
  end
end
