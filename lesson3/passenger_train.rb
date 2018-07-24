class PassengerTrain < Train
  def add_coach(coach)
    return unless coach.instance_of? PassengerCoach
    super(coach)
  end
end
