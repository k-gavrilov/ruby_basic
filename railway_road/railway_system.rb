class RailwaySystem

  TRAIN_TYPES = [CargoTrain, PassengerTrain]
  COACH_TYPES = [CargoCoach, PassengerCoach]
  TRAIN_COACH_MAP = { CargoTrain => CargoCoach,
                      PassengerTrain => PassengerCoach}

  def initialize()
    @stations_list = []
    @trains_list = []
    @routes_list = []
    @coaches_list = []
  end

  def create_cargo_coach(volume)
    coaches_list << CargoCoach.new(volume)
  end

  def create_passenger_coach(seats_num)
    coaches_list << PassengerCoach.new(seats_num)
  end

  def create_station(station_name)
    stations_list << Station.new(station_name)
  end

  def create_train(train_id, train_type_index)
    train = TRAIN_TYPES.at(train_type_index).new(train_id)
    trains_list << train
    "Успешно создан поезд #{train}"
  end

  def create_route(first_station_index, second_station_index)
    first_station = stations_list.at(first_station_index)
    second_station = stations_list.at(second_station_index)
    route = Route.new(first_station, second_station)
    routes_list << route
  end

  def remove_station_from_route(route_index, index_in_middle)
    route = routes_list.at(route_index)
    index = index_in_middle + 1
    station = stations_list(index)
    route.remove_station(station)
  end

  def add_station_to_route(route_index, station_index)
    route = routes_list.at(route_index)
    station = stations_list.at(station_index)
    route.add_station(station)
  end

  def assign_route_to_train(train_index, route_index)
    route = routes_list.at(route_index)
    train = trains_list.at(train_index)
    train.route = route
  end

  def add_coach_to_train(train_index, coach_index)
    train = trains_list.at(train_index)
    coach = appropriate_coaches_by_train(train)[coach_index]
    coach.attach(train)
  end

  def remove_coach_from_train(train_index, coach_index)
    train = trains_list.at(train_index)
    coaches = coaches_list.select { |coach| coach.attached_to == train }
    coach = coaches.at(coach_index)
    coach.detach
    "Вагон #{coach} отцеплен"
  end

  def occupy_volume_in_coach(coach_index, volume)
    cargo_coaches = appropriate_coaches_by_type(CargoCoach)
    coach = cargo_coaches.at(coach_index)
    coach.occupy_volume(volume)
    coach.to_s
  end

  def occupy_seat_in_coach(coach_index)
    passenger_coaches = appropriate_coaches_by_type(PassengerCoach)
    coach = passenger_coaches.at(coach_index)
    coach.occupy_seat
    coach.to_s
  end

  def move_train_forward(train_index)
    train = trains_list.at(train_index)
    train.move_forward
  end

  def move_train_backward(train_index)
    train = trains_list.at(train_index)
    train.move_backward
  end

  def stations_str_list
    list_str(stations_list)
  end

  def trains_str_list
    list_str(trains_list)
  end

  def routes_str_list
    list_str(routes_list)
  end

  def coaches_str_list_to_attach(train_index)
    coaches = appropriate_coaches_by_train(trains_list.at(train_index))
    list_str(coaches)
  end

  def coaches_in_train_str_list(train_index)
    # debug, some problem with coach selection
    train = trains_list.at(train_index)
    coaches = coaches_list.select { |coach| coach.attached_to == train }
    list_str(coaches)
  end

  def cargo_coaches_str_list
    list_str(appropriate_coaches_by_type(CargoCoach))
  end

  def passenger_coaches_str_list
    list_str(appropriate_coaches_by_type(PassengerCoach))
  end

  def train_types_str_list
    list_str(TRAIN_TYPES)
  end

  def coaches_types_str_list
    list_str(COACH_TYPES)
  end

  def show_stations_to_remove(route_index)
    route = routes_list.at(route_index)
    stations = route.full_list
    return if stations.size == 2
    stations.slice!(1..-2)
    list_str(stations)
  end

  def show_trains_on_station(station_index)
    station = stations_list.at(station_index)
    train_list = station.train_list
    list_str(train_list)
  end

  private

  def appropriate_coaches_by_train(train)
    coaches_list.select { |coach| coach.class == TRAIN_COACH_MAP[train.class]}
  end

  def appropriate_coaches_by_type(coach_type)
    coaches_list.select { |coach| coach.class == coach_type}
  end

  def list_str(list)
    return if list.nil?
    list.map do |item|
      "#{list.find_index(item) + 1}: #{item}"
    end
  end

  # def identify_list_by_class(class_identifier)
  #   case class_identifier.to_s
  #   when 'Station'
  #     stations_list
  #   when 'Train'
  #     trains_list
  #   when 'Route'
  #     routes_list
  #   end
  # end

  attr_reader :stations_list, :trains_list, :routes_list, :coaches_list
end
