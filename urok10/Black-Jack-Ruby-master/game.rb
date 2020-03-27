require_relative 'deck'
require_relative 'interface'
require_relative 'player'
require_relative 'dealer'
class Game
  BET = 10

  attr_accessor :interface

  def initialize(deck)
    @interface = Interface.new
    username = @interface.init_user
    @player = Player.new(username)
    @dealer = Dealer.new
    @bank = 0
    @deck = deck
    @winner = nil
    @interface.notify('Добро пожаловать в игру Black Jack')
  end

  def refund_bet
    @winner.cash += @bank unless @winner.nil?
    @bank = 0
  end

  def deal_card(player)
    player.hand.add_card(@deck.cards.pop)
  end

  def deal_cards
    2.times do
      deal_card(@player)
      deal_card(@dealer)
    end
  end

  def make_bets
    [@player, @dealer].each { |player| player.make_bet(BET) }
    @bank += 20
  end

  def start_game
    init_game
    rounds
    game_ends
  end

  def rounds
    loop do
      @interface.notify(@player.show_stat)
      @interface.show_hand_masked(@dealer.name, @dealer.hand.size)
      case @interface.round_dialog
      when 2 then player_add_card
      when 3 then break
      end
      deal_card(@dealer) if @dealer.take_card?
      break if !@player.can_take_card? && !@dealer.can_take_card?
    end
  end

  def init_game
    reset_all
    make_bets
    deal_cards
  end

  def reset_all
    @deck.reset_deck
    [@player, @dealer].each { |player| player.hand.reset }
  end

  def player_add_card
    if !@player.can_take_card?
      @interface.notify('Полная рука')
    else
      deal_card(@player)
    end
  end

  def game_ends
    @interface.notify(@player.show_stat)
    @interface.notify(@dealer.show_stat)
    p_score = @player.hand.score
    d_score = @dealer.hand.score
    autolose? ? autolose : choice_winner(p_score, d_score)
    refund_bet
    @interface.show_cash(@player.name, @player.cash)
  end

  def autolose?
    @player.lose? || @dealer.lose?
  end

  def autolose
    @interface.notify('Перенабор очков')
    if @player.lose? && @dealer.lose?
      @interface.notify('Ничья')
      @winner = nil
    elsif @player.lose?
      @interface.notify('Вы проиграли')
      @winner = @dealer
    else
      @interface.notify('Вы выиграли')
      @winner = @player
    end
  end

  def choice_winner(p_score, d_score)
    if p_score == d_score
      @interface.notify('Ничья')
      @winner = nil
    elsif p_score > d_score
      @interface.notify('Вы выиграли')
      @winner = @player
    else
      @interface.notify('Вы проиграли')
      @winner = @dealer
    end
  end

  def can_play_again?
    @player.enought_cash?(BET)
  end
end
