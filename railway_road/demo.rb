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
require_relative 'accessors.rb'
require_relative 'validation.rb'

train = CargoTrain.new("aaa-aa")
puts "Train attributes are valid? Answer:#{train.valid?}"

puts "\nProviding not a String for ID attribute:"
begin
  train2 = CargoTrain.new(2)
rescue RuntimeError => e
  puts e.message
end

puts "\nProviding non-valid string for ID attribute:"
begin
  train3 = CargoTrain.new("Я не поеду")
rescue RuntimeError => e
  puts e.message
end

puts "\nChecking presence of non existing attribute :nonsense:"
class Train
  REQUIRED_VALIDATIONS = [
    {obj: :nonsense, val_type: :presence}
  ].freeze
end
begin
  train4 = Train.new("bbb-bb")
rescue RuntimeError => e
  puts e.message
end

station2 = Station.new("Володарская")
station2.name = "Сергеево"
puts "\nStation names history:"
puts station2.name_history

station2.director_name = "Иванов"
puts "\nTrying to set inappropriate type(Integer) to director_name:"
begin
station2.director_name = 0
rescue TypeError => e
  puts e.message
end
