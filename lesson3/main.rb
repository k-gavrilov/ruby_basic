require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'coach.rb'
require_relative 'passenger_coach.rb'
require_relative 'cargo_coach.rb'
require_relative 'railway_system.rb'
# require_relative 'demo.rb'

class UserMenu

  def initialize(railway_road)
    @railway_road = railway_road
  end

  def create_route
    puts 'Выберите начальную станцию маршрута:'
    stations_str_list = railway_road.stations_str_list
    station1 = choose_option(stations_str_list)
    return if station1.nil?
    puts 'Выберите конечную станцию маршрута'
    station2 = choose_option(stations_str_list)
    return if station2.nil?
    railway_road.create_route(station1, station2)
  end

  def remove_station_in_route
    puts 'Выберите маршрут'
    routes_str_list = railway_road.routes_str_list
    route = choose_option(routes_str_list)
    return if route.nil?
    puts 'Выберите станцию для удаления'
    stations_str_list = railway_road.show_stations_to_remove(route)
    if stations_str_list.nil?
      puts 'Ошибка, нет промежуточных станций'
      return
    end
    station = choose_option(stations_str_list)
    return if station.nil?
    railway_road.remove_station_from_route(route, station)
  end

  def add_station
    puts 'Выберите маршрут'
    routes_str_list = railway_road.routes_str_list
    route = choose_option(routes_str_list)
    return if route.nil?
    puts 'Выберите станцию:'
    stations_str_list = railway_road.stations_str_list
    station = choose_option(stations_str_list)
    return if station.nil?
    railway_road.add_station_to_route(route, station)
  end

  def create_train
    puts 'Введите номер поезда:'
    train_id = gets.chomp
    return unless train_id
    puts 'Выберите тип поезда'
    train_types_str_list = railway_road.train_types_str_list
    train_type = choose_option(train_types_str_list)
    return if train_type.nil?
    railway_road.create_train(train_id, train_type)
  end

  def assign_route
    puts 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    train = choose_option(trains_str_list)
    return if train.nil?
    puts 'Выберите маршрут:'
    routes_str_list = railway_road.routes_str_list
    route = choose_option(routes_str_list)
    return if route.nil?
    railway_road.assign_route_to_train(train, route)
  end

  def add_coach
    puts 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    train = choose_option(trains_str_list)
    return if train.nil?
    railway_road.add_coach_to_train(train)
  end

  def remove_coach
    puts 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    train = choose_option(trains_str_list)
    return if train.nil?
    railway_road.remove_coach_from_train(train)
  end

  def create_station
    puts 'Введите название станции'
    station_name = gets.chomp
    return unless station_name
    railway_road.create_station(station_name)
  end

  def show_station_list
    puts railway_road.stations_str_list
  end

  def show_trains_on_station
    puts 'Выберите станцию:'
    stations_str_list = railway_road.stations_str_list
    station = choose_option(stations_str_list)
    return if station.nil?
    puts railway_road.show_trains_on_station(station)
  end

  def manip_station
    loop do
      puts 'Выберите действие со станциями'
      puts '0: Создать'
      puts '1: Показать список всех станций'
      puts '2: Посмотреть список поездов на станции'
      puts '3: Выберите этот пункт для возврата в главное меню'
      puts '4: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0,4)
        puts 'Некорректный ввод, введите целое число от 0 до 4 включительно'
        next
      end

      case choice
      when 0
        create_station
      when 1
        show_station_list
      when 2
        show_trains_on_station
      when 3
        break
      when 4
        abort
      end
    end
  end

  def manip_train
    loop do
      puts 'Выберите действие с поездами'
      puts '0: Создать'
      puts '1: Назначить маршрут поезду'
      puts '2: Добавить вагон'
      puts '3: Отцепить вагон'
      puts '4: Выберите этот пункт для возврата в главное меню'
      puts '5: Выберите этот пункт для выхода'

      choice = gets.to_i
      unless choice.between?(0, 5)
        puts 'Некорректный ввод, введите целое число от 0 до 5 включительно'
        next
      end

      case choice
      when 0
        create_train
      when 1
        assign_route
      when 2
        add_coach
      when 3
        remove_coach
      when 4
        break
      when 5
        abort
      end
    end
  end

  def manip_route
    loop do
      puts 'Выберите действие со маршрутами'
      puts '0: Создать'
      puts '1: Удалить станцию'
      puts '2: Добавить станицию'
      puts '3: Выберите этот пункт для возврата в главное меню'
      puts '4: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0,4)
        puts 'Некорректный ввод, введите целое число от 0 до 4 включительно'
        next
      end

      case choice
      when 0
        create_route
      when 1
        remove_station_in_route
      when 2
        add_station
      when 3
        break
      when 4
        abort
      end
    end
  end

  def main_menu
    loop do
      puts 'Выберите с чем Вы хотите работать?'
      puts '0: Станции'
      puts '1: Поезда'
      puts '2: Маршруты'
      puts '3: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0, 3)
        puts 'Некорректный ввод, введите целое число от 0 до 3 включительно'
        next
      end

      case choice
      when 0
        manip_station
      when 1
        manip_train
      when 2
        manip_route
      when 3
        break
      end
    end
  end

  private

  def choose_option(string_arr)
    threshold = string_arr.size - 1
    puts string_arr
    choice = gets.to_i
    return unless choice.between?(0, threshold)
    choice
  end

  attr_accessor :railway_road
end

user_menu = UserMenu.new(RailwaySystem.new)
user_menu.main_menu
