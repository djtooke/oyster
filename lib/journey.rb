require_relative './oyster_card.rb'

class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :end_station, :fare

  def initialize(options = {})
    @entry_station = options[:entry]
    @end_station = options[:end_station]
    @in_progress = options[:in_progress]
  end

  def in_progress?
    @in_progress
  end

  def complete(options = {})
    @end_station = options[:end_station]
    @double_touch_in = options[:double_touch_in] unless options[:double_touch_in].nil?
    @in_progress = false
    @penalty = options[:penalty]
    fare
  end

  def fare
    @penalty ? @fare = PENALTY_FARE : @fare = MIN_FARE
  end

end
