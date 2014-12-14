.PHONY: test

gem:
	gem build secure-password.gemspec

test:
	cutest test/*.rb
