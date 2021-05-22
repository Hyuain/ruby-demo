require 'rails_helper'

RSpec.describe 'Record', type: :request do
  context "Create" do
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
  context "Destroy" do
    it '未登录不能删除 record ' do
      record = Record.create amount: 100000, category: 'income'
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '删除一个 record' do
      sign_in
      record = Record.create amount: 100000, category: 'income'
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end
end
