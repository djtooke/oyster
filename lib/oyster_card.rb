require_relative './card_history.rb'
require_relative './journey.rb'

class OysterCard
  attr_reader :balance, :current_journey
  MAX_CAPACITY = 90


  def initialize(balance = 0)
    @balance = balance
    @history = CardHistory.new
    @current_journey = Journey.new({entry_station: nil, in_progress: false})
  end

  def touch_in(station)
    double_touch_in(station) if touched_in?
    raise 'Not enough balance' if @balance < Journey::MIN_FARE
    @current_journey = Journey.new(entry: station, in_progress: true)
  end

  def touch_out(station)
    @current_journey.in_progress? ? @current_journey.complete(end_station: station) : @current_journey.complete(end_station: station, penalty: true)
    deduct(@current_journey.fare)
    log_journey
    clear_journey
  end

  def touched_in?
    @current_journey.in_progress?
  end

  def top_up(amount)
    raise "Max balance of #{MAX_CAPACITY} exceeded" if exceed_limit?(amount)
    @balance += amount
  end

  def readlog
    @history.read
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_limit?(amount)
    @balance + amount > MAX_CAPACITY
  end

  def log_journey
    @history.save(@current_journey)
  end

  def clear_journey
    @current_journey = Journey.new({in_progress: false})
  end

  def double_touch_in(station)
    @current_journey.complete(double_touch_in: station, penalty: true)
    deduct(@current_journey.fare)
    log_journey
  end

end
