require 'rails_helper'

RSpec.describe ValidationErrorsComponent, type: :component do
  class Person
    include ActiveModel::Model

    attr_accessor :name, :age
    validates :name, presence: true
    validates :age, numericality: true
  end

  before do
    render_inline described_class.new(model: model)
  end

  context 'when the model is valid' do
    let(:model) { Person.new(name: 'Brandan', age: 'maybe') }

    it 'does not render' do
      expect(rendered_component).to be_empty
    end
  end

  context 'when the model has errors' do
    let(:model) { Person.new.tap(&:valid?) }

    it 'renders an alert' do
      expect(rendered_component).to have_css('.alert.alert-warning')
    end

    it 'includes all error messages' do
      expect(rendered_component).to have_css('li', text: "Name can't be blank")
      expect(rendered_component).to have_css('li', text: "Age is not a number")
    end
  end
end
