vowels_hash = {}
('a'..'z').each_with_index do |char, index|
  vowels_hash[char] = index + 1 if char =~ /^[aeiou]/
end

puts vowels_hash.inspect
