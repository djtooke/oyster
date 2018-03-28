class CardHistory

attr_reader :record

  def initialize
    @record = []
    @total = 0
  end

  def save(touchin, touchout)
    @total += 1
    @record << {:journey => @total, :entry => touchin, :exit => touchout}
  end

  def read
    @record
  end

end
