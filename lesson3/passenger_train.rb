class PassengerTrain < Train
  def add_coach(coach)
    return unless coach.class = PassengerCoach.to_s
    super(coach)
  end
end
