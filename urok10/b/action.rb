class Action
  att_reader :score
  CARD_LIMIT = 3
  BLACK_JET = 21

  def initialize
    @card = []
    @score = 0
  end

  def add_card(card)
    @card << card
    @score +=10 if CARD::PICTURE.include?(card.value) and (card.value != 'A')
    if card.value == 'A'
      if (@score + 11) <= BLACK_JET
        @score +=11
      else 
        @score +=1
      end
    end
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
