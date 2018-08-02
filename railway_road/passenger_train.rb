class PassengerTrain < Train
  def add_coach(coach)
    validate_coach!(coach)
    super(coach)
  end

  protected

  def validate_coach!(coach)
    raise 'coach type error' unless coach.instance_of? PassengerCoach
  end

  def type
    'Пассажирский'
  end
end
