.PHONY: dev install

dev:
	@echo "Starting development server..."
	@bin/dev

install:
	@bundle install
	@rails db:setup
	@rails db:migrate

format:
	@rubocop -a
	@rubocop -x
