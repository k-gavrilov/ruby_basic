puts "Введите первую сторону треугольника в любых единицах"
side1 = gets.chomp.to_f
puts "Введите вторую сторону треугольника в любых единицах"
side2 = gets.chomp.to_f
puts "Введите третью сторону треугольника в любых единицах"
side3 = gets.chomp.to_f

if (side1 <= 0) || (side2 <= 0) || (side3 <= 0)
  puts "Стороны треугольника должны быть положительными числами, перезапустите
  программу с корректными значениями"
else
  sorted_sides = [side1, side2, side3].sort
  hyp = sorted_sides[2]
  cat1 = sorted_sides[1]
  cat2 = sorted_sides[0]

  if ((cat1**2 + cat2**2) - hyp**2).abs < 0.000001
    print "Треугольник прямоугольный "
    print "и равнобедренный" if cat1 == cat2
    puts
  else
    puts "Введенные значения не являются длинами сторон прямоугольного
    треугольника"
  end
end
