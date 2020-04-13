require_relative 'card'
class Action
  attr_accessor :score
  CARD_LIMIT = 3
  BLACK_JET = 21

  def initialize
    @card = []
    @score = 0
  end
  def choice_score
    if (@score + 11) <= BLACK_JET
      @score += 11
    else 
      @score += 1
    end
    puts @score
  end
  def add_card(card)
    @card << card
    if Card::PICTURE.include?(card.value) && (card.value != 'A')
      @score += 10
    end
    if card.value == 'A'
      choice_score
    end
    @score += card.value.to_i if (2..10).include?(card.value)
  end
  def reset
    @score = 0
    @card = []
  end

  def size
    @card.size
  end

  def show_card
    @card.each do |card|
      puts card.show_card
      puts "Текущее количество очков - #{@score}"
    end
  end


end
