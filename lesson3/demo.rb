


def seed
  railway_system = RailwaySystem.new
  # test create stations
  railway_system.create_station(Station.new('Новый Петергоф'))
  railway_system.create_station(Station.new('Старый Петергоф'))
  railway_system.create_station(Station.new('Университет'))
  railway_system.create_station(Station.new('Мартышкино'))
  railway_system.create_station(Station.new('Ломоносов'))
  railway_system.create_station(Station.new('Сосновый Бор'))
  railway_system.create_train(PassengerTrain.new('Lastochka777'))
  railway_system.create_train(PassengerTrain.new('Lastochka778'))
  railway_system.create_train(CargoTrain.new('Tutu001'))
  railway_system.create_route(Route.new(railway_system.fetch_station(0),
                                        railway_system.fetch_station(5)))
  railway_system.fetch_route(0).add_station(railway_system.fetch_station(3))

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
  railway_system
end
