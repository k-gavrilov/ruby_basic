arr = [1, 1]
loop do
  new_element = arr.last(2).sum
  break if new_element >= 100
  arr << new_element
end

puts arr.inspect
