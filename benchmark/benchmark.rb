require 'rubygems'
require 'benchmark'

# 测试前现在本地建立词库索引

require_relative "../lib/filter_word"

module Rails
  def self.root
    File.join File.dirname(__FILE__),'../'
  end

  def self.env
    'test'
  end
end

%w(100 1000 10000).each do |word_count|
  puts "\n  --#{word_count} words string-----"
  text = ''
  File.open(File.join(File.dirname(__FILE__),"text_test_#{word_count}.txt"), "r") { |f| text = f.read }
     
  puts '  Run a single time using local'
  puts Benchmark.measure { FilterWord.clean(text) }

  # n = 50
  # puts "  Run #{n} times by local"
  # Benchmark.bm do |x|
  #   x.report { 1.upto(n) do ; FilterWord.clean(text); end }
  # end

  # puts "  Run #{n} times by remote"
  # Benchmark.bm do |x|
  #   x.report { 1.upto(n) do ; FilterWord.clean_by_remote(text); end }
  # end
end



