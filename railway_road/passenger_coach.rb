require_relative 'coach.rb'

class PassengerCoach < Coach
  attr_reader :occupied_seats_num

  def initialize(seats_num)
    super()
    @seats_num = seats_num
    @occupied_seats_num = 0
    validate!
  end

  def occupy_seat
    self.occupied_seats_num += 1 if occupied_seats_num < seats_num
  end

  def free_seats_num
    seats_num - occupied_seats_num
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def type
    'Пассажирский'
  end

  def to_s
    "#{super.to_s} Свободных мест: #{free_seats_num}" \
    " Занятых мест: #{occupied_seats_num}"
  end

  protected

  def validate!
    raise "Seats number not an Integer" unless seats_num.instance_of? Integer
    raise "Negative seats_num" if seats_num < 0
    true
  end

  attr_reader :seats_num
  attr_writer :occupied_seats_num
end
