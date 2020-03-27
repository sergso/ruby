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
    puts "3)"
  end