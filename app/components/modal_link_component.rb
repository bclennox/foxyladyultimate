class ModalLinkComponent < ViewComponent::Base
  def initialize(title: , url: , button_text: )
    @title = title
    @url = url
    @button_text = button_text
  end

  private

  attr_reader :title, :url, :button_text
end
