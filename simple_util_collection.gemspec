require File.dirname(__FILE__) + "/lib/simple_util_collection/version"

Gem::Specification.new do |s|
  s.name             = "simple_util_collection"
  s.version          = SimpleUtilCollection::VERSION
  s.authors          = ["Jeano V."]
  s.email            = ["github@jeano.net"]
  s.summary          = "A collection of utilities I've used more than once"
  s.homepage         = "http://github.com/jgithub/simple_util_collection"
  s.files            = `git ls-files`.split("\n")
  s.licenses         = ['MIT']
end