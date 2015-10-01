secure-password
===============

Set and authenticate against [bcrypt][bcrypt] passwords.
It uses the [bcrypt-ruby][bcrypt-ruby] gem.

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

Bcrypt's cost factor
--------------------

The default cost factor used by `BCrypt` is `10`. To change it, use:

```ruby
BCrypt::Engine.cost = 12
```

Check ["Cost Factors"][cost-factors] section for more information.

Testing
-------

bcrypt is designed to be slow to make cracking exponentially difficult.
However, tests don't need this security measures. To speed up your tests,
you can decrease the default cost factor to the minimum:

```ruby
BCrypt::Engine.cost = BCrypt::Engine::MIN_COST
```

Contributing
------------

- Fork the project.
- Use `make install` to install dependencies.
- Use `make test` to run the test suite.
- Create a pull request with your changes.

Installation
------------

```
$ gem install secure-password
```

[bcrypt]: http://www.openbsd.org/papers/bcrypt-paper.pdf
[bcrypt-ruby]: https://github.com/codahale/bcrypt-ruby
[cost-factors]: https://github.com/codahale/bcrypt-ruby#cost-factors
[scrivener]: https://github.com/soveran/scrivener
