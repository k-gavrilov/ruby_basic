def is_valid_float?(str)
  str =~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
end

puts "Введите коэффициент a"
a = gets.chomp
puts "Введите коэффициент b"
b = gets.chomp
puts "Введите коэффициент c"
c = gets.chomp

if !(is_valid_float?(a) && is_valid_float?(b) && is_valid_float?(c))
  puts "a,b,c должны быть дробными или целыми числами в десятично системе" \
       "исчисления. Пожалуйста, перезапустите программу с корректными" \
       "значениями"
else
  a = a.to_f
  b = b.to_f
  c = c.to_f

  if a == 0
    puts "Это уравнение не является квадратным"
  else
    d = b**2 - 4 * a * c

    if d > 0
      puts "x1 = #{(- b + Math.sqrt(d)) / (2 * a)} x2 = #{(- b - Math.sqrt(d)) / (2 * a)}"
    elsif d == 0
      puts "x = #{- b / (2 * a)}"
    else
      puts "Корней нет"
    end
  end
end
