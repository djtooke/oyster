require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { OysterCard.new }
  subject(:oyster_card10) { OysterCard.new(10) }
  let(:station) { double :station }
  let(:station2) { double :station }

  it 'responds with a balance of 0' do
    expect(oyster_card.balance).to eq 0
  end

  it 'has a record of the last touched in station' do
    expect(oyster_card).to respond_to (:current_journey)
  end

  it 'has a variable to record the journey history' do
    expect(oyster_card).to respond_to (:readlog)
  end

  describe '.top_up' do
    it 'increases balance by specified amount' do
      oyster_card.top_up(10)
      expect(oyster_card.balance).to eq 10
    end
  end

  describe '.exceed_limit?' do
    it 'returns true when limit exceeded' do
      expect(oyster_card.send(:exceed_limit?, 91)).to eq(true)
    end
  end

  describe '.touch_in' do
    it 'starts a journey' do
      oyster_card10.touch_in(station)
      # expect(oyster_card10.in_journey).to eq(true)
      expect(oyster_card10.current_journey).not_to be_nil
    end

    it 'should prevent touching in when balance is too low' do
      expect{ oyster_card.touch_in(station) }.to raise_error 'Not enough balance'
    end

    it 'records the last station touched in' do
      oyster_card10.touch_in(station)
      expect(oyster_card10.current_journey.entry_station).to eq station
    end

    context 'when already touched in' do
     # Test for double_touch_in
    end
  end

  describe '.touch_out' do

    it 'it ends a journey' do
      oyster_card10.touch_in(station)
      oyster_card10.touch_out(station2)
      expect(oyster_card10.current_journey.in_progress?).to be false
    end

    it 'charges minimum fare for a journey on touch out' do
      oyster_card10.touch_in(station)
      expect { oyster_card10.touch_out(station2) }.to change { oyster_card10.balance }.from(10).to(9)
    end

    it 'saves the journey start/end stations to the record' do
      oyster_card10.touch_in(station)
      oyster_card10.touch_out(station2)
      expect(oyster_card10.readlog[0].entry_station).to match(station)
    end

    context 'when not touched in' do
      # Test for double touch out
    end
  end

  describe '.touched_in?' do
    it 'returns true when touched in' do
      oyster_card10.touch_in(station)
      expect(oyster_card10).to be_touched_in
    end

    it 'returns false when not touched in' do
      oyster_card10.touch_in(station)
      oyster_card10.touch_out(station2)
      expect(oyster_card10).not_to be_touched_in
    end
  end
end
