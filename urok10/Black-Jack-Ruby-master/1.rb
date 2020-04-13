class Card
  attr_reader :value, :suit

  SUITS = %w[♠ ♥ ♣ ♦].freeze
  PICTURES = %w[J Q K A].freeze

  def initialize(suit, value)
    @value = value
    @suit = suit
  end

  def show_card
    " #{@suit}#{@value} "
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    fill_deck
    # shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def fill_deck
    Card::SUITS.each do |suit|
      ("2".."10").each do |value|
        @cards << Card.new(suit, value)
      end
      Card::PICTURES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def reset_deck
    @cards = []
    fill_deck
    shuffle!
  end
end

class Hand
  attr_reader :score

  CARD_LIMIT = 3
  BLACK_JACK = 21

  def initialize
    @cards = []
    @score = 0
  end

  def choice_ace_score
    if @score + 11 <= BLACK_JACK
      @score += 11
    else
      @score += 1
    end
  end

  def add_card(card)
    @cards << card
    @score += 10 if Card::PICTURES.include?(card.value) && (card.value != "A")
    if card.value == "A"
      choice_ace_score
    end
    @score += card.value.to_i if ("2".."10").include? card.value
  end

  def size
    @cards.size
  end

  def reset
    @cards = []
    @score = 0
  end

  def __str__
    str = ""
    @cards.each { |card| str += card.show_card }
    str += " Текущее кол-во очков - #{@score}"
  end

  alias show __str__
end
class Player
  attr_accessor :hand, :cash, :name

  def initialize(name)
    @name = name
    @cash = 100
    @hand = Hand.new
  end

  def make_bet(bet_value)
    @cash -= bet_value
  end

  def lose?
    @hand.score > Hand::BLACK_JACK
  end

  def enought_cash?(bet_value)
    @cash >= bet_value
  end

  def can_take_card?
    @hand.size < Hand::CARD_LIMIT
  end

  def __str__
    str = "Игрок #{name}: #{@hand.show}"
  end

  alias show_stat __str__
end

class Dealer < Player
  SCORE_LIMIT = 17

  def initialize
    super("Dealer")
  end

  def take_card?
    can_take_card? && (hand.score < SCORE_LIMIT)
  end
end
class Interface
  def init_user
    puts "Введите имя"
    gets.chomp
  end

  def notify(message)
    puts "*" * 15
    puts message
  end

  def round_dialog
    puts "Выберите действие:"
    puts "1. Пропустить ход"
    puts "2. Взять карту"
    puts "3. Открыть карты"
    gets.to_i
  end

  def show_cash(name, cash)
    puts "На счету игрока #{name}: #{cash}"
  end

  def show_hand_masked(name, hand_size)
    puts "Игрок #{name} имеет #{hand_size} карты"
  end

  def again?
    puts "Сыграть еще раз?"
    puts "Введите 1, если хотите сыграть еще"
    gets.to_i === 1
  end

  def end_session
    puts "Игра окончена"
    puts "Спасибо за игру"
  end
end
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
    @interface.notify("Добро пожаловать в игру Black Jack")
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
      @interface.notify("Полная рука")
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
    @interface.notify("Перенабор очков")
    if @player.lose? && @dealer.lose?
      @interface.notify("Ничья")
      @winner = nil
    elsif @player.lose?
      @interface.notify("Вы проиграли")
      @winner = @dealer
    else
      @interface.notify("Вы выиграли")
      @winner = @player
    end
  end

  def choice_winner(p_score, d_score)
    if p_score == d_score
      @interface.notify("Ничья")
      @winner = nil
    elsif p_score > d_score
      @interface.notify("Вы выиграли")
      @winner = @player
    else
      @interface.notify("Вы проиграли")
      @winner = @dealer
    end
  end

  def can_play_again?
    @player.enought_cash?(BET)
  end
end
game = Game.new(Deck.new)
game.start_game
loop do
  if game.can_play_again? && game.interface.again?
    game.start_game
  else
    game.interface.end_session
    break
  end
end
