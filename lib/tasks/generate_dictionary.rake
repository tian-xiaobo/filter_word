require 'yaml'

namespace :filter_word do
  desc "generate harmonious dictionary for use"
  task :generate => :environment do

    puts "Processing chinese words..."
    tree = {}
    model = ENV['model']

    chinese_dictionary = model.nil? ? 'chinese_dictionary.txt' : "#{model}_chinese_dictionary.txt"
    english_dictionary = model.nil? ? 'english_dictionary.txt' : "#{model}_english_dictionary.txt"
    chinese_dictionary_path = File.join(Rails.root, 'config','filter_word', chinese_dictionary)
    english_dictionary_path = File.join(Rails.root, 'config','filter_word', english_dictionary)

    process(chinese_dictionary_path, tree)
    File.open(hash_path(model), "wb") {|io| Marshal.dump(tree, io)}  
    puts 'chinese_dictionary hash Done'

    puts 'Processing english words...'
    english_dictionary_list = []
    process_english_words(english_dictionary_path, english_dictionary_list)
    File.open(yaml_path(model), "wb") {|io| YAML::dump(english_dictionary_list, io)} 
    puts 'english_dictionary yaml Done'
  end
end

def process_english_words(path,list)
  File.open(path, 'r') do |file|
    file.each_line{|line| list << line.gsub!("\n",'') }
  end
end

def process(path, tree)
  File.open(path, 'r') do |file|
    file.each_line do |line|
      node = nil
      line.chars.each do |c|
        next if c == "\n" || c == "\r"
        if node
          node[c] ||= {}
          node = node[c]
        else
          tree[c] ||= Hash.new
          node = tree[c]
        end
      end
      node[:end] = true
    end
  end
end

def hash_path(model = nil)
  if model
    File.join(Rails.root, 'config','filter_word',"#{model}_harmonious.hash")
  else
    File.join(Rails.root, 'config','filter_word','harmonious.hash')
  end
end

def yaml_path(model = nil)
  if model
    File.join(Rails.root, 'config','filter_word',"#{model}_harmonious_english.yml")
  else 
    File.join(Rails.root, 'config','filter_word','harmonious_english.yml')
  end
end
