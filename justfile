be command:
  bundle exec {{command}}

alias c := console
console:
  bundle exec rails c

run:
  bin/dev

test spec:
  bundle exec rspec {{spec}}

deploy:
  kamal deploy
