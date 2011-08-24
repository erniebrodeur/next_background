module NextBackground
  # 
  # This class will do the actual command line parsing and in the future also 
  # contain the config file parsing instructions.
  class CliOptions
    #
    # the hash containing the final results of our option parsing.
    attr_accessor :opts
    
    #
    # the help banner
    attr_reader :banner


    private
    #
    # the parser object itself
    attr_accessor :parser

    public
    #
    # initialize our option list.
    def initialize
      @banner = "Help banner goes here."
      @parser = Trollop::Parser.new do
        opt :daemon,  "kick into daemon mode."
        opt :runonce, "change the links one time."
        opt :kill,    "kill the running daemon (if their is one)."
        opt :pid,     "return the PID of a running daemon (if there is one)."
      end
    end

    #
    # parse our argv string, raising errors if options are batty.
    def parse
      # there should be something to work with.
      if ARGV.empty?
        raise Trollop::HelpNeeded
      end
      # this calls the Trollop parser against our argument list.
      @opts = @parser.parse ARGV

      # there should be nothing left.
      if !ARGV.empty?
        raise Trollop::HelpNeeded 
      end

      # this will catch any extra problems and push out a nice educational message.
    rescue Trollop::HelpNeeded
      print "#{@banner}\n\n\n"
      @parser.educate 
      exit
    end
  end
end

