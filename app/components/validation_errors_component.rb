# frozen_string_literal: true

class ValidationErrorsComponent < ViewComponent::Base
  def initialize(model: )
    @model = model
  end

  private

  attr_reader :model

  def render?
    model.errors.any?
  end

  def error_messages
    model.errors.to_a
  end
end
