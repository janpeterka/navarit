require_relative 'lib/feedback/version'

Gem::Specification.new do |spec|
  spec.name        = 'feedback'
  spec.version     = Feedback::VERSION
  spec.authors     = [ 'Jan Peterka' ]
  spec.email       = [ 'jan.peterka@hey.com' ]
  spec.homepage    = 'https://github.com/janpeterka/kucharka-on-rails'
  spec.summary     = 'Plugin for collecting feedback from users.'
  spec.description = 'Collectiong feedback made easy. Store feedback in your app and synchronize it with your issue tracker'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = 'https://github.com/janpeterka/kucharka-on-rails'
  spec.metadata['source_code_uri'] = 'https://github.com/janpeterka/kucharka-on-rails'
  spec.metadata['changelog_uri'] = 'https://github.com/janpeterka/kucharka-on-rails/'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  # spec.add_dependency 'gitlab', '>= 4.19.0'
  # spec.add_dependency 'octokit', '>= 8.0.0'
  spec.add_dependency 'rails', '>= 7.1.1'
end
