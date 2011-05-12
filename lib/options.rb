module NextBackground
  require 'trollop'
  #
  # the hash containing the final results of our option parsing.
  attr_accessor :opts

  # 
  # This class will do the actual command line parsing and in the future also 
  # contain the config file parsing instructions.
  class Options
    @banner = "Help banner goes here."
    #
    # initialize our option list.
    def initialize
      @parser = Trollop::Parser.new do
        opt :daemon, "kick into daemon mode."
        opt :runonce, "change the links one time."
      end
    end
  end
end

