class RailwaySystem
  def initialize()
    @stations_list = []
    @trains_list = []
    @routes_list = []
  end

  # Создать станцию, получить станцию, список станций
  def create_station(station)
    stations_list << station
  end

  def fetch_station(index)
    stations_list.at(index)
  end

  # Создать поезд, получить поезд, список поездов
  def create_train(train)
    trains_list << train
  end

  def fetch_train(index)
    trains_list.at(index)
  end

  #Создать маршрут, получить маршрут, список маршрутов
  def create_route(route)
    routes_list << route
  end

  def fetch_route(index)
    routes_list.at(index)
  end

  def list_str(class_name)
    list = identify_list_by_class(class_name)
    return if list.nil?
    list.reduce("") do |res_str, item|
      res_str + "#{list.find_index(item)}: #{item}\n"
    end
  end

  def list_size(class_name)
    list = identify_list_by_class(class_name)
    list.size
  end

  private

  def identify_list_by_class(class_identifier)
    case class_identifier.to_s
    when 'Station'
      stations_list
    when 'Train'
      trains_list
    when 'Route'
      routes_list
    else
      nil
    end
  end

  attr_reader :stations_list, :trains_list, :routes_list
end
