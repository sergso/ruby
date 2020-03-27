require_relative 'card'
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
      ('2'..'10').each do |value|
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
