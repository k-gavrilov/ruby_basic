require_relative 'train.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Station
  include InstanceCounter
  include Validation
  include Accessors

  STATION = /\S+/
  REQUIRED_VALIDATIONS = [
    {obj: :name, val_type: :presence},
    {obj: :name, val_type: :type, args: String},
    {obj: :name, val_type: :format, args: STATION}
  ].freeze

  attr_reader :train_list
  attr_accessor_with_history :name
  strong_attr_accessor :director_name, String

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @train_list = []
    validate!
    @@stations << self
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

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def each_train
    train_list.each { |train| yield(train) }
  end

  def required_validations
    REQUIRED_VALIDATIONS
  end
end
