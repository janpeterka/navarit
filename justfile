be command:
  bundle exec {{command}}

alias c := console
console:
  bundle exec rails c

run:
  bin/dev

test spec:
  bundle exec rails test {{spec}}

deploy:
  kamal deploy
