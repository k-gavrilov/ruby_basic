require_relative 'labelable.rb'
require 'securerandom'

class Coach
  include Labelable

  attr_reader :id
  attr_reader :attached_to

  def initialize
    @id = SecureRandom.uuid
  end

  def detach
    attached_to.remove_coach(self) if attached_to
    self.attached_to = nil
  end

  def attach(train)
    detach if attached_to
    self.attached_to = train
    train.add_coach(self)
  end

  def to_s
    "ID: #{id} Тип: #{type}"
  end

  def type
    'Вагон'
  end

  protected

  attr_writer :attached_to
end
