puts "Введите первую сторону треугольника в любых единицах"
side1 = gets.chomp.to_f
puts "Введите вторую сторону треугольника в любых единицах"
side2 = gets.chomp.to_f
puts "Введите третью сторону треугольника в любых единицах"
side3 = gets.chomp.to_f

if (side1 <= 0) || (side2 <=0) || (side3 <= 0)
  puts "Стороны треугольника должны быть положительными числами, перезапустите
  программу с корректными значениями"
else
  potential_hep = side1
  potential_cat1 = side2
  potential_cat2 = side3

  if side2 > side1 && side2 > side3
    potential_hep = side2
    potential_cat1 = side1
    potential_cat2 = side3
  elsif side3 > side1 && side3 > side2
    potential_hep = side3
    potential_cat1 = side1
    potential_cat2 = side2
  end

  if ((potential_cat1**2 + potential_cat2**2) - potential_hep**2).abs < 0.000001
    print "Треугольник прямоугольный "
    print "и равнобедренный" if potential_cat1 == potential_cat2
    puts
  else
    puts "Введенные значения не являются длинами сторон прямоугольного
    треугольника"
  end

end
