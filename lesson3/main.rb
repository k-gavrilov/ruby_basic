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

  def initialize(railway_road)
    @railway_road = railway_road
  end
  #Функции для пунктов меню Маршрутов
  def create_route
    puts 'Выберите начальную станцию для маршрута:'
    first_station_index = choose_target_object(Station)
    return if first_station_index.nil?
    puts 'Выберите конечную станцию для маршрута:'
    last_station_index = choose_target_object(Station)
    return if last_station_index.nil?
    first_station = railway_road.fetch_station(first_station_index)
    last_station = railway_road.fetch_station(last_station_index)
    new_route = Route.new(first_station, last_station)
    railway_road.create_route(new_route)
    puts "Добавлен новый маршрут #{new_route}"
  end

  def remove_station_in_route
    puts railway_road.list_str(Route)
  end

  def add_station

  end

  #функции для пунктов меню Поездов
  def create_train

  end

  def assign_route

  end

  def add_coach

  end

  def remove_coach

  end

  # функции для пунктов меню Станций
  def create_station
    

  end

  def show_station_list

  end

  def show_trains_on_station

  end

  # функции для пунктов главного меню
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
      unless choice.between?(0,5)
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
      puts "Выберите с чем Вы хотите работать?"
      puts '0: Станции'
      puts '1: Поезда'
      puts '2: Маршруты'
      puts '3: Выберите этот пункт для выхода'
      choice = gets.to_i
      unless choice.between?(0,3)
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

  def choose_target_object(class_name)
    threshold = railway_road.list_size(class_name)
    puts railway_road.list_str(class_name)
    choice = gets.to_i
    return unless choice.between?(0, threshold)
    choice
  end

  attr_accessor :railway_road

end

user_menu = UserMenu.new(seed)
user_menu.main_menu
