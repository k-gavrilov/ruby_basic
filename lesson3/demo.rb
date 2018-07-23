require './station.rb'
require './route.rb'
require './train.rb'

# test create stations
petergof1 = Station.new('Новый Петергоф')
petergof2 = Station.new('Старый Петергоф')
uni = Station.new('Университет')
mar = Station.new('Мартышкино')
lomonosov = Station.new('Ломоносов')

# test create route
route1 = Route.new(petergof1, lomonosov)
# test adding stations to the route
route1.add_station(petergof2)
route1.add_station(uni)
route1.add_station(mar)
# test returning the list of all stations
puts 'Маршрут 1:'
puts route1.full_list

route2 = Route.new(mar, petergof2)
route2.add_station(uni)
route2.add_station(lomonosov)
route2.add_station(mar)
puts 'Маршрут 2:'
puts route2.full_list
puts
# removing stations from route
puts 'Удаляем станцию Мартышкино'
route2.remove_station(mar)
puts 'Маршрут 2:'
puts route2.full_list
puts

# test create train
puts 'Создаем поезд ласточка 777 Пассажирский 12 вагонов:'
lastochka = Train.new('777', Train::TYPE[0], 12)
puts lastochka
# test assignin route
lastochka.route = route1
puts

old_fashioned_train = Train.new('001', Train::TYPE[1], 55)
old_fashioned_train.route = route2

puts 'Создаем поезд Ласточка2 778 Пассажирский 20 вагонов:'
lastochka2 = Train.new('778', Train::TYPE[0], 20)
puts lastochka2
lastochka2.route = route1

puts
puts 'Поезда на станции Новый Петергоф'
# test train_list and aggregated train_list
puts petergof1.train_list
puts 'Кол-во пассажирских поездов на станции Новый Петергоф:'
puts petergof1.train_type_list(Train::TYPE[0])

# test moving forward
lastochka.move_forward
# Test current/previous/next stations
puts "Текущая ст. для второго поезда #{old_fashioned_train.current_station}"
puts "Следующая для второго поезда #{old_fashioned_train.next_station}"
puts "Предыдущая для второго поезда #{old_fashioned_train.previous_station}"
# test moving backword
lastochka.move_backword
puts 'Поезда на станции Новый Петергоф'
puts petergof1.train_list
puts
puts 'Поезда на станции Старый Петергоф'
puts petergof2.train_list

puts
puts lastochka
# test add coach
lastochka.add_coach
puts lastochka
# test raise speed
lastochka.raise_speed
puts "Скорость: #{lastochka.speed}"
# test add coach if speed != 0
puts 'Не могу прицепить вагон' if lastochka.add_coach.nil?
puts 'Тормозим'
# test brake
lastochka.brake
puts "Скорость: #{lastochka.speed}"
# test removing coaches
puts 'Отцепляем вагон'
lastochka.remove_coach
puts lastochka
