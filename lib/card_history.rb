class CardHistory

attr_reader :record

  def initialize
    @record = []
    @total = 0
  end

  def save(journey)
    @total += 1
    @record << journey
  end

  def read
    @record
  end

end
