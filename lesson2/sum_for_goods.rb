cart_hash = {}

loop {
  puts "Введите название товара:"
  item_name = gets.chomp
  break if item_name == "стоп"
  puts "Введите цену за единицу товара:"
  price = gets.to_f
  puts "Введите количество товара:"
  quantity = gets.to_f
  cart_hash[item_name] = { price: price, quantity: quantity }
}

puts "\n" + cart_hash.inspect + "\n"

total = 0
cart_hash.each do |name, value|
  local_sum = value[:price] * value[:quantity]
  total += local_sum
  puts "Сумма по товару #{name} = #{local_sum}"
end

puts "\nОбщая сумма = #{total}"
