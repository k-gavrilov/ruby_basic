require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'labelable.rb'
require_relative 'instance_counter.rb'

class Train
  include InstanceCounter
  include Labelable

  attr_reader :id, :speed

  ID = /^[a-zа-я0-9]{3}-{0,1}[a-zа-я0-9]{2}$/i

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
    self.speed = speed + 10
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
    arrive_to_station(route.full_list[route_index])
  end

  def move_backward
    return unless route && !route_index.zero?
    leave_station(route.full_list[route_index])
    self.route_index = route_index - 1
    arrive_to_station(route.full_list[route_index])
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

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def each_coach
    coaches_list.each { |coach| yield(coach) }
  end

  def to_s
    "ID:#{id} Тип:#{type} Кол-во вагонов:#{coaches_num}"
  end

  protected

  def validate!
    raise 'Invalid ID format' unless id.instance_of? String
    raise 'Invalid train ID' unless id =~ ID
    true
  end

  def type
    'Поезд'
  end

  private

  attr_reader :route, :coaches_list
  attr_writer :speed
  attr_accessor :route_index
end
