
# frozen_string_literal:true
class Card
  attr_reader :mast, :value

  PICTURE = ['J', 'Q', 'K', 'A'].freeze
  MAST = ['♠', '♡', '♢', '♣'].freeze

  def initialize(mast, value)
    @value = value
    @mast = mast
  end

  def show_card
    puts "#{@mast}-#{value}"
  end
end
