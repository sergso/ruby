def input_vagon(type)
  until (vagon_number_input == "x")
  puts "Укажите номер вагона. Чтобы посмотреть все номера вагонов типа \"#{type}\" - нажмите (n),\n для выхода нажмите - (х) "
  vagon_number_input = gets.chomp
    case vagon_number_input
      when "x"
        puts "!!Exit!!"
        next
      when "n"
        vagon_numbers(type)
        next
      else
        if type == CARGO
          if Vagon_cargo.vagons.detect {|k,v|v.vagon_number == vagon_number_input} != nil
            Vagon_cargo.vagons.each do |key,val|
              if val.vagon_number == vagon_number_input
                if val.vagon_hook == 1
                  raise "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
                end
                val.vagon_hook = 1
                puts "Вагон с номером #{val.vagon_number} успешно прицеплен к поезду"
              end
              break
            end

        elsif type == PASS
          if Vagon_pass.vagons.detect {|k,v|v.vagon_number == vagon_number_input} != nil
            Vagon_pass.vagons.each do |key,val|
              if val.vagon_number == vagon_number_input
                if val.vagon_hook == 1
                  raise "Вагон с номером #{val.vagon_number} уже прицеплен к поезду"
                end
                val.vagon_hook = 1
                puts "Вагон с номером #{val.vagon_number} успешно прицеплен к поезду"
              end
              break
            end
        else
          puts "Вагона с номером #{vagon_number_input} не существует. Попробуйте снова"
          next
        end
      end
  end
end
end
end
