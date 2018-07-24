require './route.rb'
require './station.rb'

class Train
  TYPE = %i[passenger cargo].freeze

  attr_reader :id, :type, :speed

  def initialize(id, type)
    @id = id
    @type = type
    @coaches_list = []
    @speed = 0
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

  def remove_coach
    return unless speed.zero?
    coaches_list.pop
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

  def move_backword
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

  def to_s
    "ID:#{id} Тип:#{type} Кол-во вагонов:#{coaches_list.size}"
  end

  private
  # в private, т.к. методы используются только внутри класса, в наследниках
  # переопределять не собираемся (относится ко всем методам в секции private)
  attr_reader :route:, :coaches_list
  attr_writer :speed
  attr_accessor :route_index
end
