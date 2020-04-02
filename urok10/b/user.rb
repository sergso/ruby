require_relative 'action'
class User
  attr_accessor :name, :cash, :action
  def initialize(name)
    @name = name
    @cash = 100
    @action = Action.new
  end
  
  def stat
    puts "Игрок #{name} "
  end
  def can_take_card?
    @action.size < Action::CARD_LIMITT
  end
  #Делаем ставку, уменьшая кошелёк
  def make_bet(bet_value)
    @cash -= bet_value
  end

end
