# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: 'https://ga.jspm.io/npm:@hotwired/turbo-rails@7.3.0/app/javascript/turbo/index.js'
pin '@hotwired/turbo', to: 'https://ga.jspm.io/npm:@hotwired/turbo@7.3.0/dist/turbo.es2017-esm.js'
pin '@rails/actioncable/src', to: 'https://ga.jspm.io/npm:@rails/actioncable@7.1.1/src/index.js'

pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js'

# stimulus controllers
pin 'stimulus' # @3.2.2
pin 'stimulus-sortable' # @4.1.1
pin '@rails/request.js', to: '@rails--request.js.js' # @0.0.8
pin 'sortablejs' # @1.15.0
pin 'stimulus-clipboard' # @4.0.1

# rich text
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
