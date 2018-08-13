# Not for use in the usual app flow

require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'coach.rb'
require_relative 'passenger_coach.rb'
require_relative 'cargo_coach.rb'
require_relative 'railway_system.rb'
require_relative 'instance_counter.rb'
require_relative 'labelable.rb'

# test Labelable
# lastochka1 = PassengerTrain.new('Las-01')
# lastochka2 = PassengerTrain.new('Лас01')
# tutu = CargoTrain.new('Tut-tu')
# puts Train.find('Las-01')
# puts Train.find('Tut-tu')
# puts lastochka1.valid?
# puts


def seed
  railway_system = RailwaySystem.new
  railway_system.create_station(station_name: 'Новый Петергоф')
  railway_system.create_station(station_name:'Старый Петергоф')
  railway_system.create_station(station_name:'Университет')
  railway_system.create_station(station_name:'Мартышкино')
  railway_system.create_station(station_name:'Ломоносов')
  railway_system.create_station(station_name:'Сосновый Бор')
  railway_system.create_train(train_id: 'Las-77', train_type_index: 1)
  railway_system.create_train(train_id: 'Las-78', train_type_index: 1)
  railway_system.create_train(train_id: 'Tut-01', train_type_index: 0)
  railway_system.create_route(first_station_index: 0, second_station_index: 5)
  railway_system.add_station_to_route(first_station_index: 0,
    second_station_index: 3)
  railway_system.create_cargo_coach(volume: 40)
  railway_system.create_passenger_coach(seats_num: 60)
  railway_system.create_passenger_coach(seats_num: 80)
  railway_system.add_coach_to_train(train_index: 0, coach_index: 0)
  railway_system.add_coach_to_train(train_index: 0, coach_index: 1)
  railway_system.assign_route_to_train(train_index: 0, route_index: 0)
  railway_system
end
