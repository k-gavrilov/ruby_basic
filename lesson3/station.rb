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

  def train_type_list
    train_type_list = {}
    train_list.each do |train|
      if train_type_list.key?(train.type)
        train_type_list[train.type] += 1
      else
        train_type_list[train.type] = 1
      end
    end
    train_type_list
  end

  def to_s
    name
  end

  private

  attr_reader :name
end
