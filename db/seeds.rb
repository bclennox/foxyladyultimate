require 'yaml'

%w{schedules players games responses users}.each do |model|
  klass = model.classify.constantize
  klass.delete_all

  YAML.load_file(File.join(File.dirname(__FILE__), 'seeds', "#{model}.yml")).each_pair do |key, attributes|
    klass.create!(attributes)
  end
end
