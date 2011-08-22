#!/usr/bin/ruby
# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( /^lib\/.*rb/ )   { fire }
# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { fire }        # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def fire
  print %x[clear] 
  puts %x[bin/next_background -r]
end

