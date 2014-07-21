require './card'

class Deck

  def initialize(count = 4)
    @cards = []
    deck = ["\u2660", "\u2665", "\u2663", "\u2666"].product(["a", Array(2..10), "j", "q", "k"].flatten)
    (deck*count).each do | card_details |
      @cards << Card.new(card_details[0], card_details[1])
    end
  end

  def shuffle!
    puts "Shuffling the cards..."
    sleep 0.5
    @cards.shuffle!
  end

  def pop
    @cards.pop
  end



end
