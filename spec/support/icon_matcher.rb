require 'nokogiri'

RSpec::Matchers.define :be_icon do |expected_icon_type|
  match do |element|
    Nokogiri::HTML(element).css('svg.bi use').first[:href].match?(/bootstrap-icons.*?\.svg##{expected_icon_type}/)
  end

  failure_message do |element|
    actual_icon_type = Nokogiri::HTML(element).css('svg.bi use').first[:href]

    "expected icon #{actual_icon_type} to be #{expected_icon_type}"
  end
end
