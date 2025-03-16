require 'rails_helper'

RSpec.describe ApplicationDecorator do
  class HarnessDecorator < ApplicationDecorator
    def fancy_star_icon
      icon(:fancy_star)
    end
  end

  describe '#icon' do
    subject { HarnessDecorator.new(Object.new).fancy_star_icon }

    it 'is the right icon' do
      expect(subject).to be_icon('fancy-star')
    end
  end
end
