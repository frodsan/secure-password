# frozen_string_literal: true

require "bcrypt"

module SecurePassword
  @cost = nil

  def self.cost
    @cost || BCrypt::Engine.cost
  end

  def self.cost=(cost)
    @cost = cost
  end

  def authenticate(unencrypted)
    BCrypt::Password.new(password_digest) == unencrypted
  end

  def password=(unencrypted, cost: SecurePassword.cost)
    self.password_digest = BCrypt::Password.create(unencrypted, cost: cost)
  end
end
