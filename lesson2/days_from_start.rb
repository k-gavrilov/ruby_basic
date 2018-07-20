months = { "Январь" => 31, "Февраль" => 28, "Март" => 31, "Апрель" => 30,
  "Май" => 31, "Июнь" => 30, "Июль" => 31, "Август" => 31, "Сентябрь" => 30,
  "Октябрь" => 31, "Ноябрь" => 30, "Декабрь" => 31 }

puts "Enter year (positive number)"
year = gets.to_i
puts "Enter number of month (1-12)"
month = gets.to_i
puts "Enter number of day"
day = gets.to_i

is_leap = (year % 400 == 0) || (year % 4 == 0) && (year % 100 != 0)
months["Февраль"] = 29 if is_leap
months_arr = months.to_a

ordinal = 0
if month > 1
(0..month - 2).each { |num| ordinal += months_arr[num][1]}
end
ordinal += day

puts ordinal
