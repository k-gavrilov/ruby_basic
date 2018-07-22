require './route.rb'
require './station.rb'

class Train
  TYPE = %i[passenger cargo].freeze

  attr_reader :id, :type, :speed, :coaches_num, :current_station

  def initialize(id, type, coaches_num)
    @id = id
    @type = type
    @coaches_num = coaches_num
    @speed = 0
  end

  def raise_speed
    self.speed = speed + 10
  end

  def brake
    self.speed = 0
  end

  def add_coach
    self.coaches_num = coaches_num + 1 if speed.zero?
  end

  def remove_coach
    self.coaches_num = coaches_num - 1 if speed.zero?
  end

  def leave_station(station)
    station.send_train(self)
  end

  def arrive_to_station(station)
    station.accept_train(self)
  end

  def route=(route)
    leave_station(current_station) if current_station
    @route = route
    self.current_station = route.full_list.first
    arrive_to_station(current_station)
  end

  def move_forward
    return unless route && current_station != route.full_list.last
    leave_station(current_station)
    current_station = next_station
    arrive_to_station(current_station)
  end

  def move_backword
    return unless route && current_station != route.full_list.first
    leave_station(current_station)
    current_station = previous_station
    arrive_to_station(current_station)
  end

  def next_station
    route.full_list[route.full_list.find_index(current_station) + 1]
  end

  def previous_station
    route.full_list[route.full_list.find_index(current_station) - 1]
  end

  def to_s
    "ID:#{id} Тип:#{type} Кол-во вагонов:#{coaches_num}"
  end

  private

  attr_reader :route
  attr_writer :speed, :coaches_num, :current_station
end
