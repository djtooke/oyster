require 'card_history'

describe CardHistory do

  it 'should exist as a class' do
    expect(CardHistory).to respond_to(:new)
  end

  it 'should contain an accessible record of journeys' do
    expect(subject).to respond_to(:record)
  end

end
