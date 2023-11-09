require 'nokogiri'

RSpec::Matchers.define :be_icon do |expected_icon_type|
  match do |element|
    Nokogiri::HTML(element).css("i.bi.bi-#{expected_icon_type}").first.present?
  end

  failure_message do |element|
    actual_class_names = Nokogiri::HTML(element).css('i').first.classes.without('bi').join('.')

    "expected icon #{actual_class_names} to be #{expected_icon_type}"
  end
end
