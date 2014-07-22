require './card'

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
    total = 0
    aces = 0
    self.cards.each do |card|
      if card.value == 'A'
        total += 11
        aces += 1
      else
        total += card.value
      end
    end

    aces.times do
      if total > 21
        total -= 10
      end
    end
    @total = total
  end

  def busted?
    @total > 21
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