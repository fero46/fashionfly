module YAML
  def self.properly_load_file(path)
    YAML.load_file path, aliases: true
  rescue ArgumentError
    YAML.load_file path
  end
end
