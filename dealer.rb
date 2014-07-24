require './player'
require './deck'

class Dealer

  @@dealer_set = false
  attr_reader :hand

  def initialize(deck)
    raise 'Cannot have more than one dealer' if @@dealer_set
    # @name = name
    @hand = Hand.new
    @deck = deck
    @@dealer_set = true
  end

  def shuffle
    puts 'Shuffling the cards...'
    sleep 0.75
    @deck.shuffle!
  end

  def deal
    @deck.pop
  end

  def hit
    if hit?
      self.hand.new_card(self.deal)
    end
  end

  def busted?
    self.hand.busted?
  end

  def hit_blackjack?
    self.hand.blackjack?
  end


  private

  def hit?
    self.hand.total <= 17
  end

end
