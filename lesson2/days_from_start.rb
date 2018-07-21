months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Enter year (positive number)'
year = gets.to_i
puts 'Enter number of month (1-12)'
month = gets.to_i
puts 'Enter number of day'
day = gets.to_i

is_leap = (year % 400).zero? || (year % 4).zero? && (year % 100 != 0)
months[1] = 29 if is_leap

ordinal = 0
ordinal += months.take(month - 1).sum if month > 1
ordinal += day

puts ordinal
