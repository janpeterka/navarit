# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: 'https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js'
pin '@hotwired/turbo', to: 'https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js'
pin '@rails/actioncable/src', to: 'https://ga.jspm.io/npm:@rails/actioncable@7.1.1/src/index.js'

pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js'

# trix editor
pin 'trix'
# pin 'trix', to: 'https://ga.jspm.io/npm:trix@2.0.7/dist/trix.esm.min.js'
pin '@rails/actiontext', to: 'actiontext.js'
# pin '@rails/actiontext', to: 'https://ga.jspm.io/npm:@rails/actiontext@7.1.1/app/assets/javascripts/actiontext.js'
pin "stimulus" # @3.2.2
