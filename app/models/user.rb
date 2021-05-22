class User < ApplicationRecord
  has_secure_password

  has_many :records

  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation, on: [:create]

  validates_format_of :email, with: /.+@.+/, if: :email, allow_blank: true # 空字符串不做此项校验
  validates_uniqueness_of :email, if: :email
  validates_length_of :password, minimum: 6, on: [:create], if: :password
end
