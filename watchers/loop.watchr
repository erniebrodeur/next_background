#!/usr/bin/ruby
# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '.*' ) { mainloop }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { mainloop }        # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def mainloop 
  puts %x[clear]
  puts %x[bin/next_background -d]
end

if __FILE__ == $0
  require 'watchr'
  script = Watchr::Script.new
  script.watch('foo') { puts 'bar' } # doesn't block
end
