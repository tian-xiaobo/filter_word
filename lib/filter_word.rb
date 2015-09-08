# encoding: utf-8

require "filter_word/rseg"
require "filter_word/version"
require "filter_word/model_additions"
require "filter_word/railtie" if defined? Rails
   

module FilterWord
  def self.clean?(input, model = nil)
    results = FilterWord::Rseg.new(input, model).segment
    results.size > 0 ? false : true
  end

  def self.clean(input, model = nil)
    results = FilterWord::Rseg.new(input, model).segment
    results.each{|result| input.gsub! /#{result}/,self.clean_word_basic(result) }
    input
  end

  def self.harmonious_words(input, model = nil)
    return FilterWord::Rseg.new(input, model).segment
  end

  def self.clean_word_basic(word)
    clearn_words = ""
    word.size.times{  clearn_words << "*" }
    clearn_words
  end

  def self.chinese_harmonious
    Rseg.instance.send(:engines).first.dictionary
  end
end
