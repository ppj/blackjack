require_relative './card'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
    @total = 0
  end

  def new_card(card)
    @cards << card if card.is_a? Card
    self.total
  end

  def total
    hand_total     = 0
    ace_count = 0
    self.cards.each do |card|
      if card.value == 'a'
        hand_total += 11
        ace_count += 1
      else
        hand_total += card.value
      end
    end

    ace_count.times do
      if hand_total > BlackJack::BLACKJACK_SCORE
        hand_total -= 10
      end
    end
    @total = hand_total
  end

  def busted?
    self.total > BlackJack::BLACKJACK_SCORE
  end

  def blackjack?
    total == BlackJack::BLACKJACK_SCORE
  end

  def clear
    @cards = []
    @total = 0
  end

  def display(hide_last = false)

    self.cards.each { print " \u231C-----\u231D " }
    puts

    self.cards.each { print " |     | " }
    puts

    if hide_last
      self.cards[0,self.cards.length-1].each { | card | print " |  #{card.suite}  | " }
      print " |  X  | "
      puts

      self.cards[0,self.cards.length-1].each { | card | print " |  %-2s | " % card.denomination }
      print " |  X  | "
      puts

    else
      self.cards.each { | card | print " |  #{card.suite}  | " }
      puts

      self.cards.each { | card | print " |  %-2s | " % card.denomination }
      puts
    end

    self.cards.each { print " |     | " }
    puts
    self.cards.each { print " \u231E-----\u231F " }

    unless hide_last
      puts "  Total: #{@total}"
    end

    puts

  end

end