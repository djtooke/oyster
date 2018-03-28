class Journey

  attr_reader :entry_station, :end_station

  def initialize(station, in_progress = true)
    @entry_station = station
    @end_station = nil
    @in_progress = in_progress
  end

  def in_progress?
    @in_progress
  end

  def complete(station)
    @end_station = station
  end

end
