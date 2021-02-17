class Session
  include ActiveModel::Model
  attr_accessor :email, :password, :user

  validates :email, presence: true
  validates :password, presence: true

  validates_format_of :email, with: /.+@.+/, if: :email
  validate :check_email, if: :email
  validates_length_of :password, minimum: 6, if: :password
  validate :check_email_password_matched, if: Proc.new{ |s| s.email.present? and s.password.present? }

  def check_email
    @user ||= User.find_by email: email
    if user.nil?
      errors.add :email, :unregistered
    end
  end

  def check_email_password_matched
    @user ||= User.find_by email: email
    if user and !user.authenticate(password)
      errors.add :password, :mismatch
    end
  end
end