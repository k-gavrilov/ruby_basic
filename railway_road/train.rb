require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'labelable.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train
  include InstanceCounter
  include Labelable
  include Validation

  ID = /^[a-zа-я0-9]{3}-{0,1}[a-zа-я0-9]{2}$/i
  REQUIRED_VALIDATIONS = [
    {obj: :id, val_type: :presence},
    {obj: :id, val_type: :type, args: String},
    {obj: :id, val_type: :format, args: ID}
  ].freeze

  attr_reader :id, :speed

  @@trains = {}

  def self.find(id)
    @@trains[id]
  end

  def initialize(id)
    @id = id
    @coaches_list = []
    @speed = 0
    validate!
    @@trains[id] = self
    register_instance
  end

  def raise_speed
    self.speed += 10
  end

  def brake
    self.speed = 0
  end

  def add_coach(coach)
    return unless speed.zero?
    coaches_list << coach
  end

  def remove_coach(coach)
    return unless speed.zero?
    coaches_list.delete(coach)
  end

  def leave_station(station)
    station.send_train(self)
  end

  def arrive_to_station(station)
    station.accept_train(self)
  end

  def route=(route)
    leave_station(route.full_list[route_index]) if route_index
    @route = route
    @route_index = 0
    arrive_to_station(route.full_list[route_index])
  end

  def move_forward
    return unless route && route.full_list.at(route_index)
    leave_station(route.full_list[route_index])
    self.route_index = route_index + 1
    station = route.full_list[route_index]
    arrive_to_station(station)
    station
  end

  def move_backward
    return unless route && !route_index.zero?
    leave_station(route.full_list[route_index])
    self.route_index = route_index - 1
    station = route.full_list[route_index]
    arrive_to_station(station)
    station
  end

  def current_station
    route_index
  end

  def next_station
    route.full_list[route_index + 1] if route.full_list.at(route_index + 1)
  end

  def previous_station
    route.full_list[route_index] unless route_index.zero?
  end

  def coaches_num
    coaches_list.size
  end

  def each_coach
    coaches_list.each { |coach| yield(coach) }
  end

  def to_s
    "ID:#{id} Тип:#{type} Кол-во вагонов:#{coaches_num}"
  end

  def required_validations
    REQUIRED_VALIDATIONS
  end

  protected

  def type
    'Поезд'
  end

  private

  attr_reader :route, :coaches_list
  attr_writer :speed
  attr_accessor :route_index
end
