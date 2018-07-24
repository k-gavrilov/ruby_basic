class CargoTrain < Train
  def add_coach(coach)
    return unless coach.class == CargoCoach.to_s
    super(coach)
  end
end
