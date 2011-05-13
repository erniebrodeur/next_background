module NextBackground
  # 
  # This is the daemon code.  This class is responsible for forking the CLI into the background
  # and calling the changebackground at regular intervals.
  #
  # usage:
  #
  # daemon = NextBackground::Daemon.new(self)
  # daemon.fork
  class Daemon
    #
    # our update method, this is what is called every X interval.
    attr_accessor :update_method

    private
    #
    # our hash of options for daemon.  This has nothing tweakable in it at the moment.
    attr_reader :options

    public
    #
    # Our options hash for daemons
    #
    # our initalize requires that you feed it a method to be called.
    def initialize(update_method)
      @update_method = update_method
      @options = {
        :app_name => "next_background",
        :dir_mode => :normal,
        :dir => "~/.cache/"
      }
    end

    #
    # pidfile
    def pidfile
      File.expand_path("#{@options[:dir]}#{@options[:app_name]}.pid")
    end
    #
    # pid
    def pid
      if File.exists? pidfile
        open(pidfile).read
      else
        nil
      end
    end
    #
    # The entry point for this class.  
    def fork
      Daemons.daemonize @options
      loop do
        update_method.call
        sleep 10
      end
    end
  end
end
