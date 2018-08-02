require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    validate!
    @transition_station_list = []
    register_instance
  end

  def add_station(station)
    validate_station!(station)
    transition_station_list << station
  end

  def remove_station(station)
    transition_station_list.delete(station)
  end

  def full_list
    [first_station] + transition_station_list << last_station
  end

  def to_s
    full_list.join(' - ')
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  protected

  def validate!
    validate_station!(first_station)
    validate_station!(last_station)
    true
  end

  def validate_station!(station)
    raise "The item isn't of type Station" if station.instance_of? Station
    true
  end

  private

  attr_reader :transition_station_list, :first_station, :last_station
end
