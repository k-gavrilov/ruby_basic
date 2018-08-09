class CargoCoach < Coach
  attr_reader :volume
  attr_reader :occupied_volume

  def initialize(volume)
    super()
    @volume = volume
    @occupied_volume = 0
    validate!
  end

  def occupy_volume(volume)
    validate_volume!(volume)
    self.occupied_volume += volume if volume <= free_volume
  end

  def free_volume
    volume - occupied_volume
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def type
    'Грузовой'
  end

  def to_s
    "#{super} Свободное место: #{free_volume}" \
    " Занятое место: #{occupied_volume}"
  end

  protected

  def validate_volume!(volume)
    raise 'Volume is not integer' unless volume.instance_of? Integer
    raise 'Negative volume' if volume < 0
    true
  end

  def validate!
    validate_volume!(volume)
  end

  attr_writer :volume
  attr_writer :occupied_volume
end
