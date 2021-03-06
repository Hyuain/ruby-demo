require 'rails_helper'

RSpec.describe User, type: :model do
  it '可以带密码创建' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.password_digest).to_not equal '123456'
    expect(user.id).to be_a Numeric
  end
  it '创建的时候必须有 email' do
    user = User.create email: '', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to equal :blank
  end
  it '创建时 email 不能被占用' do
    User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to equal :taken
  end
end
