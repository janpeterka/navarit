# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.4
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.4
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.1.3

pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"

# stimulus controllers
pin "stimulus" # @3.2.2
pin "stimulus-sortable" # @4.1.1
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.9
pin "sortablejs" # @1.15.2
pin "stimulus-clipboard" # @4.0.1

# rich text
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"

# pin 'flowbite', to: 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.0/flowbite.turbo.min.js'
