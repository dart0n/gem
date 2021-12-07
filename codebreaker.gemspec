# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.name = 'codebreaker'
  spec.version = Codebreaker::VERSION
  spec.authors = ['example']
  spec.email = ['example@m.com']

  spec.summary = 'codebreaker game'
  spec.description = 'codebreaker game gem'
  spec.homepage = 'https://example.com'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['allowed_push_host'] = 'https://example.com'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://example.com'
  spec.metadata['changelog_uri'] = 'https://example.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'fasterer', '~> 0.9'
  spec.add_dependency 'ffaker', '~> 2.20'
  spec.add_dependency 'overcommit', '~> 0.58'
  spec.add_dependency 'rake', '~> 13.0'
  spec.add_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'rubocop', '~> 1.21'
  spec.add_dependency 'rubocop-rake', '~> 0.6'
  spec.add_dependency 'rubocop-rspec', '~> 2.6'
  spec.add_dependency 'simplecov', '~> 0.21'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
