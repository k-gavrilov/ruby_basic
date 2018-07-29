require_relative 'train.rb'
require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  @@instances = []

  attr_reader :train_list

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @train_list = []
    @@instances << self
    register_instance
  end

  def accept_train(train)
    train_list << train
  end

  def send_train(train)
    train_list.delete(train)
  end

  def train_type_list(type)
    filtered_list = train_list.select { |train| train.instance_of? type }
    filtered_list.size
  end

  def to_s
    name
  end

  private

  attr_reader :name
end
