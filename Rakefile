require 'rubygems'
require 'rake/gempackagetask'

PLUGIN = "permalizer"
NAME = "permalizer"
VERSION = "0.2"
AUTHOR = "Robert R Evans"
EMAIL = "revans@robertrevans.com"
HOMEPAGE = "http://robertrevans.com"
SUMMARY = "Creates clean URLs for whatever string you send to it."

spec = Gem::Specification.new do |s|
  s.name = NAME
  s.version = VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.autorequire = PLUGIN
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :install => [:package] do
  sh %{sudo gem install pkg/#{NAME}-#{VERSION}}
end