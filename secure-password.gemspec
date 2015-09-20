Gem::Specification.new do |s|
  s.name        = "secure-password"
  s.version     = "1.0.0"
  s.summary     = "Securing your users' passwords."
  s.description = s.summary
  s.authors     = ["Francesco Rodríguez"]
  s.email       = ["frodsan@protonmail.ch"]
  s.homepage    = "https://github.com/harmoni/secure-password"
  s.license     = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "bcrypt", "~> 3.1"
  s.add_development_dependency "cutest", "~> 1.2"
end
