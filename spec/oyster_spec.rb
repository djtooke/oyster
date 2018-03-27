require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) { OysterCard.new }
  subject(:oyster_card10) { OysterCard.new(10) }

  it 'responds with a balance of 0' do
    expect(oyster_card.balance).to eq 0
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

  describe '.deduct' do
    it 'deducts specified amount' do
      oyster_card10.deduct(5)
      expect(oyster_card10.balance).to eq 5
    end
  end

  describe '.touch_in' do
    it 'starts a journey' do
      expect(oyster_card10.touch_in).to eq(true)
    end

    it 'should prevent touching in when balance is too low' do
      expect{ oyster_card.touch_in }.to raise_error 'Not enough balance'
    end

    context 'when already touched in' do
      it 'raises an error' do
        oyster_card.stub(:touched_in?) { true }
        expect{ oyster_card.touch_in }.to raise_error 'You are already touched in'
      end
    end
  end

  describe '.touch_out' do
    it 'it ends a journey' do
      oyster_card10.touch_in
      oyster_card10.touch_out
      expect(oyster_card10.in_journey).to eq(false)
    end
  end

  describe '.touched_in?' do
    it 'returns true when touched in' do
      oyster_card10.touch_in
      expect(oyster_card10).to be_touched_in
    end

    it 'returns false when not touched in' do
      oyster_card10.touch_in
      oyster_card10.touch_out
      expect(oyster_card10).not_to be_touched_in
    end
  end

end
