require 'card_history'

class OysterCard
  attr_reader :balance, :entry_station, :history
  MAX_CAPACITY = 90
  MIN_CAPACITY = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @history = CardHistory.new
  end

  def touch_in(station)
    raise 'You are already touched in' if touched_in?
    raise 'Not enough balance' if @balance < MIN_CAPACITY
    @entry_station = station
  end

  def touch_out(station)
    raise "You're not touched in" unless touched_in?
    deduct(MIN_CAPACITY)
    log_journey(@entry_station, station)
    clear_entry
  end

  def touched_in?
    @entry_station != nil
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

  def log_journey(touchin, touchout)
    @history.save(touchin, touchout)
  end

  def clear_entry
    @entry_station = nil
  end

end
