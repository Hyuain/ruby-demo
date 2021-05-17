require 'rails_helper'

RSpec.describe Record, type: :model do
  it '必须传金额' do
    record = Record.create notes: "xx", category: "outgoings"
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end
  it '必须传类型' do
    record = Record.create amount: 1200, notes: "xx"
    expect(record.errors.details[:category][0][:error]).to eq(:blank)
  end
  it 'category 只能是 outgoings 或 income' do
    expect {
      Record.create amount: 10000, category: 'outgoing'
    }.to raise_error ArgumentError
  end
end
