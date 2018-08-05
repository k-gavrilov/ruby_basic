require_relative 'labelable.rb'
require 'securerandom'

class Coach
  include Labelable

  attr_reader :id

  def initialize
    @id = SecureRandom.uuid()
  end

  def to_s
    "ID: #{id} Тип: #{type}"
  end

  def type
    'Вагон'
  end
end
