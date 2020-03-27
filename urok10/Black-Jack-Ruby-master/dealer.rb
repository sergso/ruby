class Dealer < Player
  SCORE_LIMIT = 17

  def initialize
    super('Dealer')
  end

  def take_card?
    can_take_card? && (hand.score < SCORE_LIMIT)
  end
end
