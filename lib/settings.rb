module NextBackground
  # this class is the main container for all configuration options, cli and config file.
  # It should interact like a hash for simplicites sake, including responding to a few extra overrides.
  # beyond that, it extends a 'hash' by adding a save and load method.
  class Configuration
    private
    # this is the actual hash, whenever we do anything hash related, it is to this.
    attr_accessor :main
    # this is not stored in the hash or it could be overriden.
    attr_accessor :config_directory
    # a helper variable for the main config file.
    # the file we save to will be static, in $HOME/.config/next_background/config.yaml
    attr_accessor :file
    public
    ### Overrides {{{
    # enables setting our object like a hash.
    def []=(k, v)
      @main[k.to_sym] = v
    end

    # enables returning of objects from the hash.
    def [](k)
      if @main[k]
        return @main[k]
      else
        return nil
      end
    end

    # lifts the to_yaml call since it wont' work on a class and needs a data type.
    def to_yaml
      @main.to_yaml
    end
    # }}}

    # We auto load the config file here.
    def initialize
      @main = {}
      @config_directory = File.expand_path "~/.config/next_background"
      @file = "#{@config_directory}/config.yaml"
      if File.exists? @file
        self.load
      end
    end

    def save
      if !Dir.exists? @config_directory
        FileUtils.mkdir_p @config_directory
      end

      open(@file, 'w').write @main.to_yaml
    end

    def load
      @main = YAML::load_file @file
    end
  end
end
Settings = NextBackground::Configuration.new
