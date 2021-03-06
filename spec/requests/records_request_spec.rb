require 'rails_helper'

RSpec.describe 'Record', type: :request do
  before :each do
    @user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
  end
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
      record = Record.create amount: 100000, category: 'income', user: @user
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '删除一个 record' do
      sign_in
      record = Record.create amount: 100000, category: 'income', user: @user
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end
  context 'Index' do
    it '未登录不能获取 records' do
      get '/records'
      expect(response.status).to eq 401
    end
    it '获取 record' do
      sign_in
      (1..11).to_a.each do
        Record.create amount: 100000, category: 'income', user: @user
      end
      get '/records'
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end
  context 'Show' do
    it '未登录不能获取 record' do
      record = Record.create amount: 10000, category: 'income', user: @user
      get "/records/#{record.id}"
      expect(response.status).to eq 401
    end
    it '可以获取 record' do
      sign_in
      record = Record.create amount: 10000, category: 'income', user: @user
      get "/records/#{record.id}"
      expect(response.status).to eq 200
    end
    it '不能获取不存在的 record' do
      sign_in
      get '/records/99999'
      expect(response.status).to eq 404
    end
  end
  context 'Update' do
    it '未登录不能修改 record' do
      record = Record.create amount: 10000, category: 'income', user: @user
      patch "/records/#{record.id}", params: { amount: 9999, category: 'outgoings' }
      expect(response.status).to eq 401
    end
    it '可以修改 record' do
      sign_in
      record = Record.create amount: 10000, category: 'income', user: @user
      patch "/records/#{record.id}", params: { amount: 9999, category: 'outgoings' }
      expect(response.status).to eq 200
      new_record = (JSON.parse response.body)['resource']
      expect(new_record['amount']).to eq 9999
      expect(new_record['category']).to eq 'outgoings'
    end
  end
end
