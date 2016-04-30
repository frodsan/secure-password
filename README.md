secure-password [![Build Status](https://travis-ci.org/frodsan/secure-password.svg)](https://travis-ci.org/frodsan/secure-password)
===============

Set and authenticate against [bcrypt][bcrypt] passwords.
It uses the [bcrypt-ruby][bcrypt-ruby] gem.

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem "secure-password"
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install secure-password
```

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
SecurePassword.cost = 12
```

Check ["Cost Factors"][cost-factors] section for more information.

Testing
-------

bcrypt is designed to be slow to make cracking exponentially difficult.
However, tests don't need this security measures. To speed up your tests,
you can decrease the default cost factor to the minimum:

```ruby
require "secure_password/testing"

SecurePassword.cost # => 4
```

Contributing
------------

Fork the project with:

```
$ git clone git@github.com:frodsan/secure-password.git
```

To install dependencies, use:

```
$ bundle install
```

To run the test suite, do:

```
$ rake test
```

For bug reports and pull requests use [GitHub][issues].

License
-------

SecurePassword is released under the [MIT License][mit].

[bcrypt]: http://www.openbsd.org/papers/bcrypt-paper.pdf
[bcrypt-ruby]: https://github.com/codahale/bcrypt-ruby
[cost-factors]: https://github.com/codahale/bcrypt-ruby#cost-factors
[mit]: http://www.opensource.org/licenses/MIT
[issues]: https://github.com/frodsan/secure-password/issues
[scrivener]: https://github.com/soveran/scrivener
