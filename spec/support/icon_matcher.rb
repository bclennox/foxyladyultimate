require 'nokogiri'

RSpec::Matchers.define :be_icon do |expected_icon_type, expected_class_names|
  match do |element|
    all_class_names = ['bi', *Array.wrap(expected_class_names)].join('.')

    Nokogiri::HTML(element)
      .css("svg.#{all_class_names} > use")
      .first
     &.attr('xlink:href')
     &.end_with?("##{expected_icon_type}")
  end

  failure_message do |element|
    doc = Nokogiri::HTML(element)
    actual_icon_type = doc.css('use').first.attr('xlink:href')[/#(.*)/, 1]
    actual_class_names = doc.css('svg').first.classes.without('bi').join('.')

    "expected icon #{actual_icon_type}.#{actual_class_names} to be #{expected_icon_type}.#{expected_class_names}"
  end
end
