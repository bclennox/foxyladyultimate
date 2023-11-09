module RandomQuip
  NULL = Quip.new(confirmation: "I'm coming", rejection: "I'm not coming").freeze

  def self.call
    Quip.active.sample || NULL
  end
end
