require_relative 'user'
require_relative 'coloda'
require_relative 'dealer'
require_relative 'interface'

class Game
  #Ставка за игру
  BET = 10
  attr_accessor :interface, :username, :coloda
  def initialize(coloda)
    @interface = Interface.new
    username = @interface.init_user
    @player = User.new(username)
    @dealer = Dealer.new
    puts @player
    @coloda = coloda
    @interface.notify('Welcome to Game BJ')
  end
  #Обнуляем счёт и перетасуем колоду
  def reset_all
    @coloda.reset_coloda
    @player.action.reset
    @dealer.action.reset
  end
  #Раздача карт игрокам
  def deal_card(player)
    player.action.add_card(@coloda.card.pop)
  end
  def init_game
    reset_all
    deal_cards
    make_bets
  end
#выдаём по 2 карты каждому
  def deal_cards
    2.times do
      deal_card(@player)
      deal_card(@dealer)
    end
  end
  #ставка игрока и дилера
  def make_bets
    @player.make_bet(BET)
    @dealer.make_bet(BET)
  end
end
g = Game.new(Coloda.new)