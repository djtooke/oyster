require 'card_history'
require 'journey'

class OysterCard
  attr_reader :balance, :current_journey
  MAX_CAPACITY = 90
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @history = CardHistory.new
    @current_journey = Journey.new(nil, false)
  end

  def touch_in(station)
    raise 'You are already touched in' if touched_in?
    raise 'Not enough balance' if @balance < MIN_FARE
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    raise "You're not touched in" unless @current_journey.in_progress?
    @current_journey.complete(station)
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
    @current_journey = Journey.new(nil, false)
  end

end
