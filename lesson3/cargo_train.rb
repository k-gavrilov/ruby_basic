class CargoTrain < Train
  def add_coach(coach)
    return unless coach.instance_of? CargoCoach
    super(coach)
  end
end
