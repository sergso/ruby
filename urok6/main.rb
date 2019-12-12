PASS = "pass"
CARGO = "cargo"
require_relative('train.rb')
require_relative('station.rb')
require_relative('route.rb')
require_relative('vagon.rb')
def input_key
  @input = ''
  until (@input == "x") do
    puts "Выберите операцию, нажав соответствующую клавишу или нажмите (x) - для выхода"
    puts "1) Создать новую станцию"
    puts "2) Создать новый поезд"
    puts "3) Создать вогон"
    puts "4) Добавить вагон к поезду"
    puts "5) Отцепить вагон к поезду"
    puts "6) Принять поезд на станцию"
    puts "7) Отправить поезд со станции"
    puts "8) Посмотреть список станций"
    puts "9) Посмотреть список поездов на станции"
    @input = gets.chomp
    if @input == "x"
      puts "Пока!!!"
      next
    end
    @input = @input.to_i
    case @input
      when 1
        station_create
        next
      when 2
        train_create
        next        
      when 3 #Создать новый вагон
        vagon_create
        next
      when 4
        train_hook_vagon
        next
      when 5
        train_unhook_vagon
        next
      when 6
        station_add_train
        next
      when 7
        station_send_train
        next
      when 8
        station_numbers
        next
      when 9
        station_list_train
        next
      
      end
    end
end
    
input_key