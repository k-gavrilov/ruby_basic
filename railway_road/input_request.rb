require_relative 'request.rb'

class InputRequest < Request
  INVALID_INPUT = "Некорректное значение, пожалуйста, следуйте указаниям".freeze
  BLANK = /^\s+$/

  def initialize(message, reg_exp, class_name, key, warning = nil)
    @message = message
    @reg_exp = reg_exp
    @class_name = class_name
    @warning = warning
    @key = key
  end

  def resolve(arguments)
    loop do
      puts message
      puts warning if warning
      value = gets.chomp
      raise "Move back" if value =~ BLANK
      if value !~ reg_exp
        puts INVALID_INPUT
        next
      end
      return arguments[key] = convert(value, class_name)
    end
  end

  def convert(value, class_name)
    case class_name.to_s
    when "String"
      value
    when "Integer"
      value.to_i
    when "Float"
      value.to_f
    else
      value
    end
  end

  attr_reader :message, :warning, :reg_exp, :class_name, :key
end
