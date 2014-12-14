secure-password
===============

Small library to store a secure hash of your users' passwords.
It uses the [Bcrypt][bcrypt-ruby] password hashing algorithm.

Usage
-----

```ruby
require "secure_password"

class User
  include SecurePassword

  # A `password_digest` attribute is required.
  attr_accessor :password_digest
end

user = User.new
user.password = "123456"

user.password_digest
# => "$2a$10$rHxX0jSF14JErSjrrFTB9exXPRkbzpq9.mg9nV2vHZVIjOqKQNvQe"

user.authenticate("nopassword")
# => false

user.authenticate("123456")
# => true
```

It's important to note that BCrypt hash function can handle
maximum 72 characters. It's recommended to validate the length
of a given password before creating a record.

The next example uses [Scrivener][scrivener]:

```ruby
class Signup
  attr_accessor :username
  attr_accessor :password

  def validate
    assert_present(:username)
    assert_length(:password, 8..72)
  end
end

signup = Signup.new(params)
if signup.valid?
  User.create(signup.attributes)
end
```

Installation
------------

```
$ gem install secure-password
```

[scrivener]: https://github.com/soveran/scrivener
[bcrypt-ruby]: https://github.com/codahale/bcrypt-ruby
