require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'coach.rb'
require_relative 'passenger_coach.rb'
require_relative 'cargo_coach.rb'
require_relative 'railway_system.rb'


def seed(system)
  system = RailwaySystem.new
  # test create stations
  system.create_station(Station.new('Новый Петергоф'))
  system.create_station(Station.new('Старый Петергоф'))
  system.create_station(Station.new('Университет'))
  system.create_station(Station.new('Мартышкино'))
  system.create_station(Station.new('Ломоносов'))
  system.create_station(Station.new('Сосновый Бор'))

  # test create route
  # route1 = Route.new(petergof1, lomonosov)
  # # test adding stations to the route
  # route1.add_station(petergof2)
  # route1.add_station(uni)
  # route1.add_station(mar)
  # # test returning the list of all stations
  # route2 = Route.new(mar, petergof2)
  # route2.add_station(uni)
  # route2.add_station(lomonosov)
  # route2.add_station(mar)
  # route2.add_station(sosnovka)
  # lastochka = PassengerTrain.new('777')
  # 10.times { lastochka.add_coach(PassengerCoach.new) }
  # lastochka.route = route1
  #
  # old_fashioned_train = CargoTrain.new('001')
  # 99.times { old_fashioned_train.add_coach(CargoCoach.new) }
  # old_fashioned_train.route = route2
  #
  # lastochka2 = PassengerTrain.new('778')
  # 12.times { lastochka2.add_coach(PassengerCoach.new) }
  # lastochka2.route = route1
end

railw = RailwaySystem.new
seed(railw)
puts railw.stations_list_str
