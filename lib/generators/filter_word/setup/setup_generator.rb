require "rails/generators"

module FilterWord
  module Generators
    class SetupGenerator < ::Rails::Generators::Base
      desc "This generator creates necessary at config/filter_word"
      source_root File.expand_path("../templates", __FILE__)

      def generate_setup
        copy_file "chinese_dictionary.txt", "config/filter_word/chinese_dictionary.txt"  
        copy_file "english_dictionary.txt", "config/filter_word/english_dictionary.txt"  
      end
    end
  end
end
