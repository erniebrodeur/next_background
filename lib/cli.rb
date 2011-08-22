module NextBackground
  #
  # This is the CLI code.  Any interaction with the command prompt will be done through
  # this class.  When executed from the command line, this class will also become responsible
  # for managing the neccessary memory space and configuration parser.
  class CLI

    def initialize
      @options = NextBackground::Options.new
      @daemon = NextBackground::Daemon.new(method(:run_once))

      @randomfile = NextBackground::RandomFile.new
      @randomfile.link = "/home/ebrodeur/Pictures/single"
    end

    #
    # This is the entry point for the application.  Once a CLI has been initialized, 
    # this method will run all logic and is effectively the main loop.
    def run
      @options.parse
 
      if @options.opts[:kill]
        if @daemon.pid
          puts "killing #{@daemon.pid}"
          %x[kill #{@daemon.pid}]
        else
          puts "next_background is not running."
        end
      end
      if @options.opts[:pid]
        puts @daemon.pid
      end
      if @options.opts[:daemon]
        if !@daemon.pid
          @daemon.fork
        else
          puts "next_background is already running."
        end
      end

      if @options.opts[:runonce]
        run_once
      end

      exit
    end

    #
    # our run_once method is the primary 'setting' method, I have no better place to put it
    # yet.
    # TODO: refactor this somewhere better.
    def run_once
      @randomfile.set
      %x[xfdesktop --reload]
    end
  end
end

