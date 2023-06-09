require 'spec_helper'

describe Card do
  let(:ace) { Card.new(suit: '♦', rank: 'A', value: 11, ace: true) }

  it "returns the card's rank and suit" do
    expect(ace.text).to eq("#{ace.rank}#{ace.suit}")
  end

  it "changes the ace's value from 11 to 1" do
    expect(ace.value).to eq(11)
    ace.set_ace_value
    expect(ace.value).to eq(1)
  end
end
