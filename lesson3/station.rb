require './train.rb'

class Station
  attr_reader :train_list

  def initialize(name)
    @name = name
    @train_list = []
  end

  def accept_train(train)
    train_list << train
  end

  def send_train(train)
    train_list.delete(train)
  end

  def train_type_list(type)
    filtered_list = train_list.select { |train| train.type == type }
    filtered_list.size
  end

  def to_s
    name
  end

  private

  attr_reader :name
end
