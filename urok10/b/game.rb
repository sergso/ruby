require_relative 'user'
require_relative 'coloda'
require_relative 'dealer'
require_relative 'interface'

class Game
  attr_accessor :interface, :username, :player, :dealer, :coloda
  def initialize(coloda)
    @interface = Interface.new
    username = @interface.init_user
    @player = User.new(username)
    @dealer = Dealer.new
    puts @player
    @coloda = coloda
    @interface.notify('Welcome to Game BJ')
  end


end
