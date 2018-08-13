require_relative 'input_request.rb'
require_relative 'option_request.rb'

class RailwaySystem
  TRAIN_TYPES = [CargoTrain, PassengerTrain].freeze
  COACH_TYPES = [CargoCoach, PassengerCoach].freeze
  TRAIN_COACH_MAP = { CargoTrain => CargoCoach,
                      PassengerTrain => PassengerCoach }.freeze
  ENTER_TRAIN_NAME = "Введите имя поезда:".freeze
  CHOOSE_TRAIN = "Выберите поезд:".freeze
  CHOOSE_TRAIN_TYPE = "Выберите тип поезда:".freeze
  CHOOSE_ROUTE = "Выберите маршрут:".freeze
  CHOOSE_STATION = "Выберите станцию:".freeze
  CHOOSE_COACH = "Выберите вагон:".freeze
  ENTER_STATION_NAME = "Введите название станции:".freeze
  CHOOSE_FIRST_STATION = "Введите название первой станции маршрута:".freeze
  CHOOSE_LAST_STATION = "Введите название последний станции маршрута:".freeze
  CHOOSE_COACH_TYPE = "Выберите тип вагона:".freeze
  ENTER_VOLUME = "Введите объем:".freeze
  ENTER_SEAT_NUMBER = "Введите количество мест в вагоне:".freeze
  INVALID_TRAIN_ID_WARNING = "Имя поезда должно состоять 3 букв или цифр, " \
    "опционального пробела и ещё 2 букв или цифр!!!".freeze
  NOT_BLANK = /\S+/
  INVALID_STATION_NAME_WARNING = "Имя станции не должно быть пустым!!!".freeze
  CARGO_VOLUME_WARNING = "Объем вагона должен быть целым положительным" \
    "числом!!!".freeze
  PASSENGER_SEATS_WARNING = "Количество мест должно быть положительным," \
    "целым".freeze
  VOLUME_NOT_INT_ERR = 'Volume is not integer'.freeze
  NEG_VOLUME_ERR = 'Negative volume'.freeze
  SEATS_NOT_INT_ERR = 'Seats number not an Integer'.freeze
  NEG_SEATS_ERR = 'Negative seats_num'.freeze
  INVALID_STATION_ERR = 'Invalid station name'.freeze

  def initialize
    @stations_list = []
    @trains_list = []
    @routes_list = []
    @coaches_list = []
  end

  def create_coach(parameters)
    unless (coach_type_index = parameters[:coach_type_index])
      return OptionRequest.new(CHOOSE_COACH_TYPE, coaches_types_str_list,
                               :coach_type_index)
    end
    case coach_type_index
    when 0
      create_cargo_coach(parameters)
    when 1
      create_passenger_coach(parameters)
    end
  end

  def create_cargo_coach(parameters)
    unless (volume = parameters[:volume])
      return InputRequest.new(ENTER_VOLUME, NOT_BLANK, Integer, :volume)
    end
    coach = CargoCoach.new(volume)
    coaches_list << coach
    "Вагон #{coach} был успешно создан"
  rescue RuntimeError => e
    raise e unless [VOLUME_NOT_INT_ERR, NEG_VOLUME_ERR].includes?(e.message)
    CARGO_VOLUME_WARNING
  end

  def create_passenger_coach(parameters)
    unless (seats_num = parameters[:seats_num])
      return InputRequest.new(ENTER_SEAT_NUMBER, NOT_BLANK, Integer,
                              :seats_num)
    end
    coach = PassengerCoach.new(seats_num)
    coaches_list << coach
    "Вагон #{coach} был успешно создан"
  rescue RuntimeError => e
    raise e unless [SEATS_NOT_INT_ERR, NEG_SEATS_ERR].includes?(e.message)
    PASSENGER_SEATS_WARNING
  end

  def create_station(parameters)
    unless (station_name = parameters[:station_name])
      return InputRequest.new(ENTER_STATION_NAME, NOT_BLANK, String,
                              :station_name)
    end
    station = Station.new(station_name)
    stations_list << station
    "Станция #{station} была успешно создана"
  rescue RuntimeError => e
    raise e unless e.message == "Invalid station name"
    INVALID_STATION_NAME_WARNING
  end

  def create_train(parameters)
    unless (train_id = parameters[:train_id])
      return InputRequest.new(ENTER_TRAIN_NAME, NOT_BLANK, String, :train_id)
    end
    unless (train_type_index = parameters[:train_type_index])
      str_list = train_types_str_list
      return OptionRequest.new(CHOOSE_TRAIN_TYPE, str_list, :train_type_index)
    end
    train = TRAIN_TYPES.at(train_type_index).new(train_id)
    trains_list << train
    "Успешно создан поезд #{train}"
  rescue RuntimeError => e
    raise e unless e.message == 'Invalid train ID'
    INVALID_TRAIN_ID_WARNING
  end

  def create_route(parameters)
    unless (first_station_index = parameters[:first_station_index])
      return OptionRequest.new(CHOOSE_FIRST_STATION, stations_str_list,
                               :first_station_index)
    end
    unless (second_station_index = parameters[:second_station_index])
      return OptionRequest.new(CHOOSE_LAST_STATION, stations_str_list,
                               :second_station_index)
    end
    first_station = stations_list.at(first_station_index)
    second_station = stations_list.at(second_station_index)
    route = Route.new(first_station, second_station)
    routes_list << route
    "Маршрут #{route} был успешно создан"
  end

  def remove_station_from_route(parameters)
    unless (route_index = parameters[:route_index])
      return OptionRequest.new(CHOOSE_ROUTE, routes_str_list, :route_index)
    end
    route = routes_list.at(route_index)
    stations_str_list = show_stations_to_remove(route_index)
    unless (index_in_middle = parameters[:index_in_middle])
      raise "No Stations to remove" unless stations_str_list
      return OptionRequest.new(CHOOSE_STATION, stations_str_list,
                               :index_in_middle)
    end
    station = stations_to_remove(route_index).at(index_in_middle)
    route.remove_station(station)
  end

  def add_station_to_route(parameters)
    unless (route_index = parameters[:route_index])
      return OptionRequest.new(CHOOSE_ROUTE, routes_str_list, :route_index)
    end
    unless (station_index = parameters[:station_index])
      return OptionRequest.new(CHOOSE_STATION, stations_str_list,
                               :station_index)
    end
    route = routes_list.at(route_index)
    station = stations_list.at(station_index)
    route.add_station(station)
    "Станция успешно добавлена в маршрут"
  end

  def assign_route_to_train(parameters)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    unless (route_index = parameters[:route_index])
      return OptionRequest.new(CHOOSE_ROUTE, routes_str_list, :route_index)
    end
    route = routes_list.at(route_index)
    train = trains_list.at(train_index)
    train.route = route
  end

  def add_coach_to_train(parameters)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    unless (coach_index = parameters[:coach_index])
      appropriate_coaches = coaches_str_list_to_attach(train_index)
      return OptionRequest.new(CHOOSE_COACH, appropriate_coaches, :coach_index)
    end
    train = trains_list.at(train_index)
    coach = appropriate_coaches_by_train(train)[coach_index]
    coach.attach(train)
    "Вагон успешно прицеплен"
  end

  def remove_coach_from_train(parameters)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    unless (coach_index = parameters[:coach_index])
      coaches_str_list = coaches_in_train_str_list(train_index)
      return OptionRequest.new(CHOOSE_COACH, coaches_str_list, :coach_index)
    end
    train = trains_list.at(train_index)
    coaches = coaches_list.select { |coach| coach.attached_to == train }
    coach = coaches.at(coach_index)
    coach.detach
    "Вагон #{coach} отцеплен"
  end

  def occupy_volume_in_coach(parameters)
    unless (coach_index = parameters[:coach_index])
      return OptionRequest.new(CHOOSE_COACH, cargo_coaches_str_list,
                               :coach_index)
    end
    unless (volume = parameters[:volume])
      return InputRequest.new(ENTER_VOLUME, NOT_BLANK, Integer, :volume)
    end
    cargo_coaches = appropriate_coaches_by_type(CargoCoach)
    coach = cargo_coaches.at(coach_index)
    coach.occupy_volume(volume)
    coach.to_s
  end

  def occupy_seat_in_coach(parameters)
    unless (coach_index = parameters[:coach_index])
      return OptionRequest.new(CHOOSE_COACH, passenger_coaches_str_list,
                               :coach_index)
    end
    passenger_coaches = appropriate_coaches_by_type(PassengerCoach)
    coach = passenger_coaches.at(coach_index)
    coach.occupy_seat
    coach.to_s
  end

  def move_train_forward(parameters)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    train = trains_list.at(train_index)
    station = train.move_forward
    "Поезд прибыл на станцию #{station}"
  end

  def move_train_backward(train_index)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    train = trains_list.at(train_index)
    station = train.move_backward
    "Поезд прибыл на станцию #{station}"
  end

  def show_coaches_in_train(parameters)
    unless (train_index = parameters[:train_index])
      return OptionRequest.new(CHOOSE_TRAIN, trains_str_list, :train_index)
    end
    coaches_in_train_str_list(train_index)
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
    train = trains_list.at(train_index)
    coaches = appropriate_coaches_by_train(train)
    list_str(coaches)
  end

  def coaches_in_train_str_list(train_index)
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
    stations = stations_to_remove(route_index)
    list_str(stations)
  end

  def stations_to_remove(route_index)
    route = routes_list.at(route_index)
    stations = route.full_list
    return if stations.size == 2
    stations.slice(1..-2)
  end

  def show_trains_on_station(parameters)
    unless (station_index = parameters[:station_index])
      return OptionRequest.new(CHOOSE_STATION, stations_str_list,
                               :station_index)
    end
    station = stations_list.at(station_index)
    train_list = station.train_list
    list_str(train_list)
  end

  private

  def appropriate_coaches_by_train(train)
    coaches_list.select { |coach| coach.class == TRAIN_COACH_MAP[train.class] }
  end

  def appropriate_coaches_by_type(coach_type)
    coaches_list.select { |coach| coach.class == coach_type }
  end

  def list_str(list)
    return if list.nil?
    list.map do |item|
      "#{list.find_index(item)}: #{item}"
    end
  end

  attr_reader :stations_list, :trains_list, :routes_list, :coaches_list
end
