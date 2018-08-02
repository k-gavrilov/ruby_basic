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
lastochka1 = PassengerTrain.new('Las-01')
lastochka2 = PassengerTrain.new('Лас01')
tutu = CargoTrain.new('Tut-tu')
puts Train.find('Las-01')
puts Train.find('Tut-tu')
puts lastochka1.valid?
puts

# test .all
st1 = Station.new('Новый Петергоф')
st2 = Station.new('Старый Петергоф')
st3 = Station.new('Мартышкино')
route = Route.new(st1, st2)
# route2 = Route.new(nil, st3)
puts 'Все станции:'
puts Station.all
puts
# test instance_counter
puts 'Обычных поездов:'
puts Train.instances
puts 'Грузовых:'
puts CargoTrain.instances
puts 'Пассажирских:'
puts PassengerTrain.instances

# def seed
#   railway_system = RailwaySystem.new
#   railway_system.create_station('Новый Петергоф')
#   railway_system.create_station('Старый Петергоф')
#   railway_system.create_station('Университет')
#   railway_system.create_station('Мартышкино')
#   railway_system.create_station('Ломоносов')
#   railway_system.create_station('Сосновый Бор')
#   railway_system.create_train('Lastochka777', 1)
#   railway_system.create_train('Lastochka778', 1)
#   railway_system.create_train('Tutu001', 0)
#   railway_system.create_route(0, 5)
#   railway_system.add_station_to_route(0, 3)
#   railway_system
# end
