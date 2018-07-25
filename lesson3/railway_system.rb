class RailwaySystem
  def initialize()
    @stations_list = []
    @train_list = []
    @route_list = []
  end

  # Создать станцию, получить станцию, список станций
  def create_station(station)
    stations_list << station
  end

  def station(index)
    station.at(index)
  end

  def stations_list_str
    stations_list.reduce("") do |res_str, station|
      res_str + "#{stations_list.find_index(station)}: #{station}\n"
    end
  end

  # Создать поезд, получить поезд, список поездов
  def create_train(train)
    trains_list << train
  end

  #Создать маршрут, получить маршрут, список маршрутов
  def create_route(route)
    route_list << route
  end

  private

  attr_reader :stations_list, :train_list, :route_list
end
