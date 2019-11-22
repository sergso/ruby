#Метод для ввода номера поезда
def train_number_input_def(train_type)
  if (train_type == "1")
    @train_print_type = PASS
  elsif (train_type == "2")
    @train_print_type = CARGO
  else
    puts "Не верный тип поезда. Используйте \"1\" для пассажирского и \"2\" для грузового поезда" 
    return false
  end
  train_number = ""
  until (train_number == "x")
    puts "Укажите номер поезда типа \"#{@train_print_type}\""
    puts "Чтобы посмотреть все номера поездов типа \"#{@train_print_type}\" - нажмите (n), для выхода нажмите - (х) "
    train_number = gets.chomp
    case train_number
      when "x"
        puts "!!Exit!!"
        next
      when "n"
        train_numbers(@train_print_type)
        next
      else
        if @train_print_type == PASS
          if Train_pass.trains.detect {|k,v|v.train_number == number} != nil
            Train_pass.trains.each do |key,val|
              if "#{val.train_number}" == train_number
                @train_number_input = train_number
                return @train_number_input
                break
              end
            end
          else
                puts "Не верный номер поезда! Попробуйте еще раз"
              next
          end
        elsif train_print_type == CARGO
          if Train_cargo.trains.detect {|k,v|v.train_number == number} != nil
            Train_cargo.trains.each do |key,val|
              if "#{val.train_number}" == train_number
                @train_number_input = train_number
                return @train_number_input
                break
              end
            end
          else
            puts "Не верный номер поезда! Попробуйте еще раз"
            next
        end
      end
    end
  end
end
