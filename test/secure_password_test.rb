# frozen_string_literal: true

require "bundler/setup"
require "minitest/autorun"
require "minitest/pride"
require "minitest/sugar"
require_relative "../lib/secure_password"

class User
  include SecurePassword

  attr_accessor :password_digest
end

BCrypt::Engine.cost = BCrypt::Engine::MIN_COST

class SecurePasswordTest < Minitest::Test
  test "sets hashed password" do
    user = User.new
    user.password = "123456"

    assert BCrypt::Password.valid_hash?(user.password_digest)
  end

  test "successful authentication" do
    user = User.new
    user.password = "123456"

    assert user.authenticate("123456")
  end

  test "failed authentication" do
    user = User.new
    user.password = "123456"

    assert !user.authenticate("xxxxxx")
  end
end
