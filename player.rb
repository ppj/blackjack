require './hand'

class Player

  attr_accessor :chips

  def initialize(name, chips)
    @name = name
    @chips = chips
    @hand = Hand.new
  end

  def stay?
    print "#{self.name}, would you like to hit or stay? ('h' or 's'? Default - 'h'): "
    gets.chomp.lowercase[0] == 's'
  end

  def hit (card)
    unless self.busted?
      self.hand.new_card(card) if card is_a? Card
    end
  end

  def busted?
    self.hand.busted?
  end


end