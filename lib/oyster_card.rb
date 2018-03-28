require 'card_history'

class OysterCard
  attr_reader :balance, :entry_station
  MAX_CAPACITY = 90
  MIN_CAPACITY = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
  end

  def touch_in(station)
    raise 'You are already touched in' if touched_in?
    raise 'Not enough balance' if @balance < MIN_CAPACITY
    @entry_station = station
  end

  def touch_out
    raise "You've already touched out" unless touched_in?
    deduct(MIN_CAPACITY)
    @entry_station = nil
  end

  def touched_in?
    @entry_station != nil
  end

  def top_up(amount)
    raise "Max balance of #{MAX_CAPACITY} exceeded" if exceed_limit?(amount)
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_limit?(amount)
    @balance + amount > MAX_CAPACITY
  end
end
