puts "Приветствую Вас Новый пользователь!"
print " Назовите Ваше имя: "
name = gets
p name
puts "Приветствую тебя #{name.chomp}!"

puts "Можете угадать число от 1 до 100?"

num = rand(101)
popytka = 1
ostatok_p = 10

while ostatok_p >=0 do

	if ostatok_p == 0
		puts "Количество попыток исчерпано! Игра закончен! Заданное число #{num}"
		break
		
	else 
		puts "У вас осталось #{ostatok_p} попыток"
		print "Введите число:"
		input_num = gets.chomp.to_i
		if input_num > num
			puts "Введённое число БОЛЬШЕ загаданного. Попробуйте еще раз"
		elsif input_num < num
			puts "Введённое число МЕНЬШЕ загаданного. Попробуйте еще раз"
		else
			puts "Вы угадали!!! Это число #{num}!"
			break
		end
	end
	ostatok_p = ostatok_p - popytka
	
	
end
