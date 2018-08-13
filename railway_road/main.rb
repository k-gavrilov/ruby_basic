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
require_relative 'menu_info.rb'

class UserMenu
  def initialize(railway_road)
    @railway_road = railway_road
  end

  def start_menu
    launch_continuous_menu(self, :main_menu)
  end

  private

  def create_route(parameters)
    railway_road.create_route(parameters)
  end

  def remove_station_in_route(parameters)
    railway_road.remove_station_from_route(parameters)
  end

  def add_station(parameters)
    railway_road.add_station_to_route(parameters)
  end

  def create_train(parameters)
    railway_road.create_train(parameters)
  end

  def assign_route(parameters)
    railway_road.assign_route_to_train(parameters)
  end

  def add_coach(parameters)
    railway_road.add_coach_to_train(parameters)
  end

  def remove_coach(parameters)
    railway_road.remove_coach_from_train(parameters)
  end

  def show_coaches(parameters)
    railway_road.show_coaches_in_train(parameters)
  end

  def create_station(parameters)
    railway_road.create_station(parameters)
  end

  def show_station_list(_parameters)
    puts railway_road.stations_str_list
  end

  def show_trains_on_station(parameters)
    railway_road.show_trains_on_station(parameters)
  end

  def create_coach(parameters)
    railway_road.create_coach(parameters)
  end

  def add_volume(parameters)
    railway_road.occupy_volume_in_coach(parameters)
  end

  def add_seat(parameters)
    railway_road.occupy_seat_in_coach(parameters)
  end

  def manip_station(parameters)
    menu_info = MenuInfo::STATION_MENU
    process_menu_info(menu_info, parameters)
  end

  def manip_train(parameters)
    menu_info = MenuInfo::TRAIN_MENU
    process_menu_info(menu_info, parameters)
  end

  def manip_route(parameters)
    menu_info = MenuInfo::ROUTE_MENU
    process_menu_info(menu_info, parameters)
  end

  def manip_coach(parameters)
    menu_info = MenuInfo::COACH_MENU
    process_menu_info(menu_info, parameters)
  end

  def main_menu(parameters)
    menu_info = MenuInfo::MAIN_MENU
    process_menu_info(menu_info, parameters, true)
  end

  def process_menu_info(menu_info, parameters, continuous = nil)
    unless (choice = parameters[:choice])
      return OptionRequest.new(menu_info[:message], menu_info[:str_arr],
                               :choice, menu_info[:top_level])
    end
    method = menu_info[:methods][choice]
    if continuous
      launch_continuous_menu(self, method)
    else
      launch_menu(self, method)
    end
  end

  def launch_menu(receiver, method_name)
    arguments = {}
    loop do
      response = receiver.send(method_name, arguments)
      return puts response unless response.is_a?(Request)
      response.resolve(arguments)
    end
  rescue RuntimeError => e
    return if e.message == "Move back"
  end

  def launch_continuous_menu(receiver, method_name)
    loop do
      arguments = {}
      loop do
        response = receiver.send(method_name, arguments)
        break puts response unless response.is_a?(Request)
        response.resolve(arguments)
      end
    end
  rescue RuntimeError => e
    return if e.message == "Move back"
  end

  attr_accessor :railway_road
end

user_menu = UserMenu.new(RailwaySystem.new)
user_menu.start_menu
