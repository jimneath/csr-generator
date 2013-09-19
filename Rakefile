require './generator'
require 'yaml'

task :generate do
  # load config
  config = YAML.load_file('csr.yml')
  
  # generate
  generator = Generator.new(config)
  generator.key!
  generator.csr!
end