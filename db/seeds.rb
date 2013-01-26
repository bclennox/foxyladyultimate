require 'yaml'

%w{player game response}.each do |model|
  klass = model.to_s.classify.constantize

  YAML.load_file(File.join(File.dirname(__FILE__), 'seeds', "#{model}s.yml")).each_pair do |key, attributes|
    klass.delete_all
    klass.create!(attributes)
  end
end
