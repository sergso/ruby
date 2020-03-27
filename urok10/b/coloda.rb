require_relative 'card.rb'

class Coloda
  attr_reader :card
  def initialize
    @card ||= []
    fill_coloda
    @card.shuffle!

  end
  def fill_coloda
    Card::MAST.each do |mast|
      (2..10).each do |value|
        @card << Card.new(mast, value)
      end
      Card::PICTURE.each do |pict|
        @card << Card.new(mast, pict)
      end
    end
  end
end
