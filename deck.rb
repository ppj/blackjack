require './card'

class Deck

  DECK = ["\u2660", "\u2665", "\u2663", "\u2666"].product(["a", Array(2..10), "j", "q", "k"].flatten)

  def initialize(count = 4)
    @cards = []
    (DECK*count).each do | card_info |
      @cards << Card.new(card_info[0], card_info[1])
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def pop
    @cards.pop
  end



end
