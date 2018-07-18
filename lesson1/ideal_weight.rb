puts "Введите Ваше имя"
name = gets.chomp
puts "Введите Ваш рост в сантиметрах"
height = gets.chomp.to_f

ideal_weight = height - 110

if height <= 0
  puts "Некорректный рост. Пожалуйста, перезапустите программу и введите
  рост в виде положительного целого или десятичного дробного числа в
  сантиметрах"
elsif ideal_weight >= 0
  puts "#{name}, Ваш идеальный вес: #{ideal_weight} кг"
else
  puts "Ваш вес уже оптимальный"
end
