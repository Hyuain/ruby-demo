require 'rails_helper'

RSpec.describe 'Record', type: :request do
  it '未登录不能创建 record' do
    post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
    expect(response.status).to eq 401
  end
  it '创建一个 record' do
    sign_in
    post '/records', params: { amount: 10000, category: 'outgoings', notes: '吃饭' }
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    expect(body['resource']['id']).to be
  end
end
