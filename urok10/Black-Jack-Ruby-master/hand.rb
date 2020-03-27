class Hand
  attr_reader :score

  CARD_LIMIT = 3
  BLACK_JACK = 21

  def initialize
    @cards = []
    @score = 0
  end

  def choice_ace_score
    if @score + 11 <= BLACK_JACK
        @score += 11
    else
        @score += 1
    end
  end

  def add_card(card)
    @cards << card
    @score += 10 if Card::PICTURES.include?(card.value) && (card.value != 'A')
    if card.value == 'A'
        choice_ace_score
    end
    @score += card.value.to_i if ('2'..'10').include? card.value
  end

  def size
    @cards.size
  end

  def reset
    @cards = []
    @score = 0
  end

  def __str__
    str = ''
    @cards.each { |card| str += card.show_card }
    str += " Текущее кол-во очков - #{@score}"
  end

  alias show __str__
end
