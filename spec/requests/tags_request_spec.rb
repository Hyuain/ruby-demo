require 'rails_helper'

RSpec.describe "Tags", type: :request do
  context "Create" do
    it '未登录不能创建' do
      post '/tags', params: { name: 'test' }
      expect(response.status).to eq 401
    end
    it '创建一个' do
      sign_in
      post '/tags', params: { name: 'test' }
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resource']['id']).to be
    end
  end
  context "Destroy" do
    it '未登录不能删除' do
      tag = Tag.create name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end
    it '删除一个' do
      sign_in
      tag = Tag.create name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end
  end
end
