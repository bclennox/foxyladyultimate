# frozen_string_literal: true

module RandomQuip
  class NullQuip
    def confirmation
      "I'm coming"
    end

    def rejection
      "I'm not coming"
    end
  end

  def self.call
    Quip.approved.sample || NullQuip.new
  end
end
