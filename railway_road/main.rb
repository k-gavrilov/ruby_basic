require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'coach.rb'
require_relative 'passenger_coach.rb'
require_relative 'cargo_coach.rb'
require_relative 'railway_system.rb'

require_relative 'demo.rb'

class UserMenu

  INVALID_TRAIN_ID_MSG = 'Введите корректный идентификатор поезда. ' \
         'Идентификатор может состоять из двух блоков символов(3 и 2), ' \
         'которые опционально могут быть соединены дефисом. ' \
         'В качестве символов могут выступать буквы русского и ' \
         'английского алфавита и цифры. ' \
         'Пример: las-02'.freeze

  CHOOSE_ZERO_TO_RETURN = '0: Вернуться в предыдущее меню'.freeze

  def initialize(railway_road)
    @railway_road = railway_road
  end

  def create_route
    message = 'Выберите начальную станцию маршрута:'
    stations_str_list = railway_road.stations_str_list
    menu_choice = choose_option(message, stations_str_list)
    menu_choice == 0 ? return : station1 = menu_choice - 1
    message = 'Выберите конечную станцию маршрута'
    menu_choice = choose_option(message, stations_str_list)
    menu_choice == 0 ? return : station2 = menu_choice - 1
    railway_road.create_route(station1, station2)
  end

  def remove_station_in_route
    message = 'Выберите маршрут'
    routes_str_list = railway_road.routes_str_list
    menu_choice = choose_option(message, routes_str_list)
    menu_choice == 0 ? return : route = menu_choice - 1
    message = 'Выберите станцию для удаления'
    stations_str_list = railway_road.show_stations_to_remove(route)
    if stations_str_list.nil?
      puts 'Ошибка, нет промежуточных станций'
      return
    end
    menu_choice = choose_option(message, stations_str_list)
    menu_choice == 0 ? return : station = menu_choice - 1
    railway_road.remove_station_from_route(route, station)
  end

  def add_station
    message = 'Выберите маршрут'
    routes_str_list = railway_road.routes_str_list
    menu_choice = choose_option(message, routes_str_list)
    menu_choice == 0 ? return : route = menu_choice - 1
    message = 'Выберите станцию:'
    stations_str_list = railway_road.stations_str_list
    menu_choice = choose_option(message, stations_str_list)
    menu_choice == 0 ? return : station = menu_choice - 1
    railway_road.add_station_to_route(route, station)
  end

  def create_train
    message = 'Выберите тип поезда'
    train_types_str_list = railway_road.train_types_str_list
    menu_choice = choose_option(message, train_types_str_list)
    menu_choice == 0 ? return : train_type = menu_choice - 1
    begin
      puts 'Введите номер поезда:'
      train_id = gets.chomp
      puts railway_road.create_train(train_id, train_type)
    rescue RuntimeError => e
      if e.message == 'Invalid train ID'
        puts INVALID_TRAIN_ID_MSG
        retry
      else
        raise e
      end
    end
  end

  def assign_route
    message = 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    menu_choice = choose_option(message, trains_str_list)
    menu_choice == 0 ? return : train = menu_choice - 1
    message = 'Выберите маршрут:'
    routes_str_list = railway_road.routes_str_list
    menu_choice = choose_option(message, routes_str_list)
    menu_choice == 0 ? return : route = menu_choice - 1
    railway_road.assign_route_to_train(train, route)
  end

  def add_coach
    message = 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    menu_choice = choose_option(message, trains_str_list)
    menu_choice == 0 ? return : train = menu_choice - 1
    message = 'Выберите вагон:'
    coaches = railway_road.coaches_str_list_to_attach(train)
    menu_choice = choose_option(message, coaches)
    menu_choice == 0 ? return : coach = menu_choice - 1
    railway_road.add_coach_to_train(train, coach)
  end

  def remove_coach
    message = 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    menu_choice = choose_option(message, trains_str_list)
    menu_choice == 0 ? return : train = menu_choice - 1
    message = 'Выберите вагон:'
    coaches_str_list = railway_road.coaches_in_train_str_list(train)
    menu_choice == choose_option(message, coaches_str_list)
    menu_choice == 0 ? return : coach = menu_choice - 1
    puts railway_road.remove_coach_from_train(train, coach)
  end

  def show_coaches
    message = 'Выберите поезд:'
    trains_str_list = railway_road.trains_str_list
    menu_choice = choose_option(message, trains_str_list)
    menu_choice == 0 ? return : train = menu_choice - 1
    puts railway_road.coaches_in_train_str_list(train)
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
    message = 'Выберите станцию:'
    stations_str_list = railway_road.stations_str_list
    menu_choice = choose_option(message, stations_str_list)
    menu_choice == 0 ? return : station = menu_choice - 1
    puts railway_road.show_trains_on_station(station)
  end

  def create_coach
    message = 'Выберите тип вагона'
    coaches_types_str_list = railway_road.coaches_types_str_list
    menu_choice = choose_option(message, coaches_types_str_list)
    menu_choice == 0 ? return : coach_type = menu_choice - 1
    case coach_type
    when 0
      create_cargo_coach
    when 1
      create_passenger_coach
    end
  end

  def create_cargo_coach
    puts 'Введите объем вагона:'
    volume = gets.to_i
    railway_road.create_cargo_coach(volume)
  end

  def create_passenger_coach
    puts 'Введите количество мест'
    seats_num = gets.to_i
    railway_road.create_passenger_coach(seats_num)
  end

  def add_volume
    # need rescue exceptions
    message = 'Выберите вагон'
    cargo_coaches_str_list = railway_road.cargo_coaches_str_list
    menu_choice = choose_option(message, cargo_coaches_str_list)
    menu_choice == 0 ? return : coach = menu_choice - 1
    puts 'Введите занимаемый объем:'
    volume = gets.to_i
    puts "Текущее состояние вагона: " \
         "#{railway_road.occupy_volume_in_coach(coach, volume)}"
  end

  def add_seat
    # need rescue exceptions
    message = 'Выберите вагон'
    passenger_coaches_str_list = railway_road.passenger_coaches_str_list
    menu_choice = choose_option(message, passenger_coaches_str_list)
    menu_choice == 0 ? return : coach = menu_choice - 1
    puts "Текущее состояние вагона: #{railway_road.occupy_seat_in_coach(coach)}"
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
      unless choice.between?(0, 4)
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
      puts '4: Перечислить вагоны'
      puts '5: Выберите этот пункт для возврата в главное меню'
      puts '6: Выберите этот пункт для выхода'

      choice = gets.to_i
      unless choice.between?(0, 6)
        puts 'Некорректный ввод, введите целое число от 0 до 6 включительно'
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
        show_coaches
      when 5
        break
      when 6
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
      unless choice.between?(0, 4)
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

  def manip_coach
    loop do
      puts 'Выберите действие со вагонами'
      puts '0: Создать'
      puts '1: Добавить нагрузку'
      puts '2: Занять место'
      puts '3: Выберите этот пункт для возврата в главное меню'
      puts '4: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0, 4)
        puts 'Некорректный ввод, введите целое число от 0 до 4 включительно'
        next
      end

      case choice
      when 0
        create_coach
      when 1
        add_volume
      when 2
        add_seat
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
      puts '3: Вагоны'
      puts '4: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0, 4)
        puts 'Некорректный ввод, введите целое число от 0 до 4 включительно'
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
        manip_coach
      when 4
        break
      end
    end
  end

  private

  def choose_option(message, string_arr)
    loop do
      puts message
      puts CHOOSE_ZERO_TO_RETURN
      threshold = string_arr.size
      puts string_arr
      choice = gets.to_i
      return choice if choice.between?(0, threshold)
      puts 'Значение должно быть из предложенных вариантов!'
    end
  end

  attr_accessor :railway_road
end

user_menu = UserMenu.new(RailwaySystem.new)
#user_menu = UserMenu.new(seed)
user_menu.main_menu
