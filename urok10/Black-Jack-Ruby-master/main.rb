require_relative 'game'
require_relative 'deck'

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
