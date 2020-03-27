require_relative 'hand'
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
    @hand.score > Hand:: BLACK_JACK
  end

  def enought_cash?(bet_value)
    @cash >= bet_value
  end

  def can_take_card?
    @hand.size < Hand:: CARD_LIMIT
  end

  def __str__
    str = "Игрок #{name}: #{@hand.show}"
  end
  alias show_stat __str__
end
