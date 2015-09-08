# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "filter_word/version"

Gem::Specification.new do |s|
  s.name        = "filter_word"
  s.version     = FilterWord::VERSION
  s.authors     = ["xiaobo"]
  s.email       = ["peterwillcn@gmail.com"]
  s.homepage    = "https://github.com/tian-xiaobo/filter_word"
  s.summary     = %q{filter any words that need to be harmonized}
  s.description = %q{和谐检测用于检查输入是否包含中文或英文敏感词.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"

end
