require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'coach.rb'
require_relative 'passenger_coach.rb'
require_relative 'cargo_coach.rb'

def seed
  # test create stations
  petergof1 = Station.new('Новый Петергоф')
  petergof2 = Station.new('Старый Петергоф')
  uni = Station.new('Университет')
  mar = Station.new('Мартышкино')
  lomonosov = Station.new('Ломоносов')
  sosnovka = Station.new('Сосновый Бор')

  # test create route
  route1 = Route.new(petergof1, lomonosov)
  # test adding stations to the route
  route1.add_station(petergof2)
  route1.add_station(uni)
  route1.add_station(mar)
  # test returning the list of all stations
  route2 = Route.new(mar, petergof2)
  route2.add_station(uni)
  route2.add_station(lomonosov)
  route2.add_station(mar)
  route2.add_station(sosnovka)
  lastochka = PassengerTrain.new('777')
  10.times { lastochka.add_coach(PassengerCoach.new) }
  lastochka.route = route1

  old_fashioned_train = CargoTrain.new('001')
  99.times { old_fashioned_train.add_coach(CargoCoach.new) }
  old_fashioned_train.route = route2

  lastochka2 = PassengerTrain.new('778')
  12.times { lastochka2.add_coach(PassengerCoach.new) }
  lastochka2.route = route1
end
