class Interface
  attr_reader :player
  def init_user
    print "Добро пожаловать в игру. Введите Ваше имя:"
    gets.chomp
  end
  def begin_game (name)
    puts "Приветствуем Вас #{name}!"
    puts "Выбарите действие:"
    puts "1) Начало игры"
    puts "2) Покинуть игру"
    gets.chomp.to_i
  end
  
  def notify(message)
    puts '-*-' * 10
    puts message
  end

  def action
    puts "Выберите действие:"
    puts "1. Пропустить ход"
    puts "2. Взять карту"
    puts "3. Открыть карты"
    gets.chomp.to_i
  end
  def show_cache(name, cache)
    puts "На счету игрока #{name} - #{cache}"
  end
  def show_end_card(name, end_card)
    puts "Игрок #{name} имеет следующие карты: #{end_card}"
  end
end