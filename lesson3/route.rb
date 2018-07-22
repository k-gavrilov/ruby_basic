class Route
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @transition_station_list = []
  end

  def add_station(station)
    transition_station_list << station
  end

  def remove_station(station)
    transition_station_list.delete(station)
  end

  def full_list
    [first_station] + transition_station_list << last_station
  end

  private

  attr_reader :transition_station_list, :first_station, :last_station
end
