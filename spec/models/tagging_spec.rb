require 'rails_helper'

RSpec.describe Tagging, type: :model do
  it '必须传 record' do
    tag = Tag.create name: 'test'
    tagging = Tagging.create tag: tag
    expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
    expect(tagging.errors[:record][0]).to eq('记录不能为空')
  end
  it '必须传 tag' do
    record = Record.create amount: 10000, category: 'income'
    tagging = Tagging.create record: record
    expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
    expect(tagging.errors[:tag][0]).to eq('标签不能为空')
  end
  it '可以创建关联' do
    tag = Tag.create name: 'test'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    record = Record.create amount: 10000, category: 'income', user: user
    Tagging.create record: record, tag: tag
    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
  end
  it '可以多对多关联' do
    tag1 = Tag.create name: 'test1'
    tag2 = Tag.create name: 'test2'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    record1 = Record.create amount: 10000, category: 'income', user: user
    record2 = Record.create amount: 10000, category: 'income', user: user
    Tagging.create record: record1, tag: tag1
    Tagging.create record: record1, tag: tag2
    Tagging.create record: record2, tag: tag1
    Tagging.create record: record2, tag: tag2
    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
