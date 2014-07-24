require './player'
require './dealer'
require './prompt'


class BlackJack
  attr_accessor :player, :dealer, :deck

  include Prompt

  def initialize
    player_name   = prompt("Welcome to the BlackJack table, your name?", 'Alex')
    chips         = prompt("How many chips would you like to buy #{player_name}", '100').to_i

    number_of_decks = "gibberish"
    until [1, 2, 4, 6, 8].index(number_of_decks)
      number_of_decks = prompt("Enter the number of decks you would like to play with [1, 2, 4, 6, 8]", '4').to_i
    end
    @deck         = Deck.new(number_of_decks)
    @player       = Player.new(player_name, chips)
    @dealer       = Dealer.new(@deck)
    @dealer.shuffle
    puts "Game On, #{@player.name}!"
  end


  def play

    default_bet = '20'

    while @player.chips > 0
      new_game = prompt("Ready to start a round? [y/<anything else>]", 'y').downcase[0]
      unless new_game == 'y'
        break
      end
      system 'cls'

      puts "You have #{@player.chips} chips"

      bet = 20
      while true
        bet = prompt("Place your bet #{@player.name}", default_bet).to_i
        if bet < 1
          puts "Come on #{@player.name}, you have to place a valid bet!"
        elsif bet <= @player.chips
          default_bet = "#{bet}"
          break
        else
          puts "You have only #{@player.chips} chips remaining"
          default_bet = "#{@player.chips}"
        end
      end

      # initial dealing
      2.times do
        @player.hit(@dealer.deal)
        @dealer.hit
      end

      display_hands

      # if player gets a blackjack after the initial dealing
      if @player.hit_blackjack?
        if @dealer.hit_blackjack?
          display_hands "Game pushes"
        else
          display_hands "You hit a BlackJack! You win #{@player.name}!!"
          @player.chips += get_bet_result(bet)
        end
      else
        game_over = false

        # player's turn
        while true
          hit = prompt("Would you like to hit or stay, #{@player.name}? [h/s]", 'h').downcase[0]
          unless hit == 'h'
            break
          end
          @player.hit(@dealer.deal)
          display_hands
          if @player.busted?
            display_hands "You have busted. I win!"
            @player.chips += get_bet_result(bet, 'lost')
            game_over = true
            break
          elsif @player.hit_blackjack?
            if @dealer.hit_blackjack? == 21
              display_hands "Game pushes"
            else
              display_hands "You hit a BlackJack! You win #{@player.name}!!"
              @player.chips += get_bet_result(bet)
            end
            game_over = true
            break
          end
        end

        # dealer's turn
        unless game_over
          while @dealer.hand.total < 17
            @dealer.hit
            display_hands
            sleep 0.5
            if @dealer.busted?
              display_hands "I have busted. You win #{@player.name}!"
              @player.chips += get_bet_result(bet)
              game_over = true
            elsif @dealer.hit_blackjack?
              display_hands "I hit a BlackJack!! I win!!!"
              @player.chips += get_bet_result(bet, 'lost')
              game_over = true
            end
          end
        end

        # if no winner / loser yet
        unless game_over
          if @player.hand.total > @dealer.hand.total
            display_hands "I lose. You win #{@player.name}!"
            @player.chips += get_bet_result(bet)
          elsif @player.hand.total == @dealer.hand.total
            display_hands "Game pushed! Nobody loses!!"
          else
            display_hands "I win! You lose #{@player.name}!!"
            @player.chips += get_bet_result(bet, 'lost')
          end
        end

      end

      clear_hands

    end

    if @player.chips == 0
      puts "Sorry, you have run out of chips!"
    else
      puts "Let me encash your #{@player.chips} chips for you"
    end
    puts "Great having you here #{@player.name}...\nSee you later!"

  end


  private

  def get_bet_result(bet, result='won')
    if result == 'won'
      bet/2
    else
      -bet
    end
  end

  def clear_hands
    @player.hand.clear
    @dealer.hand.clear
  end


  def display_hands(game_over_msg = "" )
    system "cls"
    @dealer.hand.display(game_over_msg.empty?)
    @player.hand.display
    unless game_over_msg.empty?
      puts game_over_msg
      puts "### GAME OVER ###\n\n"
    end
  end




end

g = BlackJack.new
g.play
