class PopulatePlayerShortNamesJob < ApplicationJob
  def perform
    PopulatePlayerShortNames.call
  end
end
