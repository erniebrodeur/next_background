module NextBackground
  #
  # This is the CLI code.  Any interaction with the command prompt will be done through
  # this class.  When executed from the command line, this class will also become responsible
  # for managing the neccessary memory space and configuration options.
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
      if @options.opts[:daemon]
        puts 'daemon'
      end

      if @options.opts[:runonce]
        puts 'runonce'
      end

      exit
      # TODO: method this out.
      %x[xfdesktop --reload]
    end
  end
end

