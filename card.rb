class Card

  attr_reader :suite, :denomination

  def initialize(s, d)
    @suite = s
    @denomination = d
  end

  def value
    if self.denomination == 'a'
      'a'
    elsif self.denomination.to_i == 0
      10
    else
      self.denomination.to_i
    end
  end


end