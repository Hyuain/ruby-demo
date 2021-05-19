require 'rails_helper'

RSpec.describe 'Users', type: :request do
  it '创建用户' do
    mailer = spy('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    post '/users', params: { email: '123@qq.com', password: '123456', password_confirmation: '123456' }
    expect(response.status).to eq 200
    expect(UserMailer).to have_received :welcome_email
    expect(mailer).to have_received :deliver_later
  end
  it '无法获得当前用户' do
    get '/me'
    expect(response).to have_http_status :not_found
    expect(response.body.blank?).to be true
  end
  it '可以获得当前用户' do
    user = sign_in
    get '/me'
    p body
    body = JSON.parse(response.body)
    expect(response).to have_http_status :ok
    expect(body['resource']['id']).to eq user.id
  end
end
