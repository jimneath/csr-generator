require 'bundler'
Bundler.require

class Generator
  def initialize(config = {})
    @config = config
  end
  
  def key!
    @key = R509::PrivateKey.new(bit_length: @config['key_size'])
    write(:key, @key.key)
  end
  
  def csr!
    @csr = R509::CSR.new(
      subject: [
        ['CN', @config['domain']], 
        ['O' , @config['organisation']],
        ['OU', @config['department']],
        ['L' , @config['city']],
        ['ST', @config['state']],
        ['C' , @config['country']],
        ['emailAddress', @config['email']]
      ],
      san_names: @config['alt_names'],
      key: @key
    )
    
    write(:csr, @csr.to_s)
  end
  
  protected
  
  def write(ext, data)
    File.open(file_name(ext), 'w') do |f|
      f.write(data)
    end
  end
  
  def file_name(extension)
    File.join('output', [@config['domain'], extension].join('.'))
  end
end