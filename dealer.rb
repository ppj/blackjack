require './player'
require './deck'

class Dealer

  def initialize(name, deck)
    @name = name
    @hand = Hand.new

    @deck = deck
  end

  def shuffle
    puts "Shuffling the cards..."
    sleep 0.75
    @deck.shuffle!
  end

  def deal
    @deck.pop
  end


end
