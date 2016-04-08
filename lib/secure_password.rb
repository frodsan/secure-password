# frozen_string_literal: true

require "bcrypt"

module SecurePassword
  def authenticate(unencrypted)
    BCrypt::Password.new(password_digest) == unencrypted
  end

  def password=(unencrypted)
    self.password_digest = BCrypt::Password.create(unencrypted)
  end
end
