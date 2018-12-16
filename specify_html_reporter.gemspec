
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "specify_html_reporter/version"
require "date"

Gem::Specification.new do |spec|
  spec.name          = "specify_html_reporter"
  spec.version       = SpecifyHtmlReporter::VERSION
  spec.date          = Date.today.strftime("%Y-%m-%d")
  spec.authors       = ["Jeff Nyman"]
  spec.email         = ["jeffnyman@gmail.com"]

  spec.summary       = %q{HTML Report for Specify}
  spec.description   = %q{HTML Report for Specify}
  spec.homepage      = "https://github.com/jeffnyman/specify_html_reporter"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "rspec-core"
  spec.add_runtime_dependency "activesupport"
end
