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
  railway_system.create_station('Новый Петергоф')
  railway_system.create_station('Старый Петергоф')
  railway_system.create_station('Университет')
  railway_system.create_station('Мартышкино')
  railway_system.create_station('Ломоносов')
  railway_system.create_station('Сосновый Бор')
  railway_system.create_train('Las-77', 1)
  railway_system.create_train('Las-78', 1)
  railway_system.create_train('Tut-01', 0)
  railway_system.create_route(0, 5)
  railway_system.add_station_to_route(0, 3)
  railway_system.create_cargo_coach(40)
  railway_system.create_passenger_coach(60)
  railway_system.create_passenger_coach(80)
  railway_system.add_coach_to_train(0, 0)
  railway_system.add_coach_to_train(0, 1)
  railway_system.assign_route_to_train(0, 0)
  railway_system
end
