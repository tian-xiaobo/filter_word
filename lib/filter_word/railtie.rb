module FilterWord
  class Railtie < Rails::Railtie
    
    rake_tasks do
      load "tasks/generate_dictionary.rake"
    end

    initializer 'FilterWord.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end

  end
end