require 'rails_helper'

RSpec.describe ApplicationDecorator do
  class HarnessDecorator < ApplicationDecorator
    def fancy_star_icon
      icon('fancy_star', classes: ['extra', 'super'])
    end
  end

  describe '#icon' do
    let(:decorator) { HarnessDecorator.new(Object.new) }
    let(:doc) { Nokogiri::HTML(decorator.fancy_star_icon) }
    let(:subject) { doc.css('i').first.classes }

    it 'includes the required "bi" class' do
      expect(subject).to include('bi')
    end

    it 'dasherizes the icon name' do
      expect(subject).to include('bi-fancy-star')
    end

    it 'includes the extra classes' do
      expect(subject).to include('extra')
      expect(subject).to include('super')
    end
  end
end
