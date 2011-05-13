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
    # a reference to our parent
    attr_reader :parent

    private
    #
    # our hash of options for daemon.  This has nothing tweakable in it at the moment.
    attr_reader :options

    #
    # Our options hash for daemons
    #
    # our initalize requires that you feed it a parent object or it can't execute run_once.
    def initialize(parent)
      @parent = parent
      @options = {
        :app_name => "next_background",
        :dir_mode => :normal,
        :dir => "~/.cache/"
      }
    end

    #
    # The entry point for this class.  
    def fork
      Daemons.daemonize @options
      loop do
        @parent.run_once
        sleep 10
      end
    end
  end
end
