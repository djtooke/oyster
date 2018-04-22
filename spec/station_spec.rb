require 'station'

describe Station do

let (:subject) {Station.new("Kings Cross", 1)}

  it 'should have an exposed name instance variable' do
    expect(subject).to respond_to(:name)
  end

  it 'should have an exposed zone instance variable' do
    expect(subject).to respond_to(:zone)
  end

end
