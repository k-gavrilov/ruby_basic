arr = [1, 1]
(2..99).each { |index| arr << arr[index - 1] + arr[index - 2] }
puts arr.inspect
