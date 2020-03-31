class Dealer < User
  DEALER_SCORE = 15
  def initialize
    super('Dealer')
  end
  def take_card?
    can_take_card? && (action.score < DEAER_LIMIT)
  end
end
