be command:
  bundle exec {{command}}

alias c := console
console:
  bundle exec rails c

alias r := run
run:
  bin/dev

test spec:
  bundle exec rspec {{spec}}

deploy:
  kamal deploy
