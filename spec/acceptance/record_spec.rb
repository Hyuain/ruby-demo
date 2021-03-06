require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Records' do
  let(:user){ User.create email: '1@qq.com', password: '123456', password_confirmation: '123456' }
  let(:record){ Record.create amount: 1000, category: 'income', user: user }
  let(:id){ record.id }
  post '/records' do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型: outgoings|income', type: :string, required: true
    parameter :notes, '备注', type: :string
    example '创建记账' do
      sign_in
      do_request(amount: 100000000, category: 'income', note: '工资')
      expect(status).to eq 200
    end
  end

  delete '/records/:id' do
    example "删除记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
end

module RspecApiDocumentation::DSL
  module Endpoint
    def sign_in(user = nil)
      no_doc do
        user ||= User.create(email: 'spec_test_helper@qq.com', password: '123456', password_confirmation: '123456')
        client.post '/sessions', { email: user.email, password: user.password }
      end
      user
    end
  end
end