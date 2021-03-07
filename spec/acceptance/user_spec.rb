require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  post '/users' do
    parameter :email, '邮箱', type: :string, required: true
    parameter :password, '密码', type: :string, required: true
    parameter :password_confirmation, '确认密码', type: :string, required: true
    example '注册用户' do
      mailer = spy('mailer')
      allow(UserMailer).to receive(:welcome_email).and_return(mailer)
      do_request(email: '1@qq.com', password: '123456', password_confirmation: '123456')
      expect(status).to eq 200
      expect(UserMailer).to have_received :welcome_email
      expect(mailer).to have_received :deliver_later
    end
  end
end