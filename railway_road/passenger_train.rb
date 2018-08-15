class PassengerTrain < Train
  validate :id, :presence
  validate :id, :type
  validate :id, :format, ID
  def add_coach(coach)
    validate_coach!(coach)
    super(coach)
  end

  protected

  def validate_coach!(coach)
    raise 'coach type error' unless coach.instance_of? PassengerCoach
    true
  end

  def type
    'Пассажирский'
  end
end
