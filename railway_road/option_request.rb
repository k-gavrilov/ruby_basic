require_relative 'request.rb'

class OptionRequest < Request
  INVALID_INPUT = "Некорректное значение, пожалуйста, следуйте указаниям".freeze

  def initialize(message, string_arr, key, top_level = nil)
    @message = message
    @string_arr = string_arr
    @key = key
    @return_message = top_level ? 'для выхода' : 'для предыдущего меню'
  end

  def resolve(arguments)
    loop do
      puts message
      threshold = string_arr.size
      puts string_arr
      puts "Выберите #{threshold} #{return_message}"
      choice = gets.to_i
      raise "Move back" if choice == threshold
      return arguments[key] = choice if choice.between?(0, threshold)
      puts INVALID_INPUT
    end
  end

  attr_reader :message, :return_message, :string_arr, :key
end
