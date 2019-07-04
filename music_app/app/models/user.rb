# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :text             not null
#  password_digest :text             not null
#  session_token   :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

  validates :email, :password_digest, :session_token, uniqueness: true, presence: true
  validates :password, length: {minimum: 8, allow_nil: true}

  after_initialize :ensure_session_token


  attr_reader :password

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return user if user && user.is_password?(password)
    nil
  end


  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_sesssion_token!
    self.session_token = User.generate_session_token
    self.update!(session_token: self.session_token)
    self.session_token
  end

  def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest)
    bcrypt_password.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
