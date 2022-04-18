# frozen_string_literal: true

require_relative "lib/minitest/set/version"

Gem::Specification.new do |spec|
  spec.name          = "minitest-set"
  spec.version       = Minitest::Set::VERSION
  spec.authors       = ["Kasper Timm Hansen"]
  spec.email         = ["hey@kaspth.com"]

  spec.summary       = "Set configurations for the duration of a test or a block with automatic reset."
  spec.homepage      = "https://github.com/kaspth/minitest-set"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "https://github.com/kaspth/minitest-set/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest"
end
