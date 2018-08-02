class CargoTrain < Train
  def add_coach(coach)
    validate_coach!
    super(coach)
  end

  protected

  def validate_coach!(coach)
    raise 'coach type error' unless coach.instance_of? CargoCoach
  end

  def type
    'Грузовой'
  end
end
