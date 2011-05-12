module NextBackground
  #
  # This is the CLI code.  Any interaction with the command prompt will be done through
  # this class.  When executed from the command line, this class will also become responsible
  # for managing the neccessary memory space and configuration parser.
  class CLI

    def initialize
      @dir = NextBackground::RandomFile.new
      @options = NextBackground::Options.new
      @dir.link = "/home/ebrodeur/Pictures/test_link"
      @dir.dir = "/home/ebrodeur/Pictures/1920x1080"
    end

    #
    # This is the entry point for the application.  Once a CLI has been initialized, 
    # this method will run all logic and is effectively the main loop.
    def run
      @options.parse

      if @options.opts[:daemon]
        puts 'daemon'
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
      @dir.set_link
      #%x[xfdesktop --reload]
    end
  end
end

