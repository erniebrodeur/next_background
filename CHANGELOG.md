# Release Notes:

Pending changes, (in git but not tagged with a version)
=====
* Cleaned up the documentation and convered from rdoc to markdown, silly github.
* Added a timeout value to the application to manually control the timeout duration.
* Added deep pid checking.  Instead of it failing and expecting you to clean up the pid file, it will now delete it and fork anyway. 

0.3.1
=====
* Added a configuration file, this resides in ~/.config/next\_background/config.yaml and contains a few
basic settings lifted out ImageList and the caching code.
* Moved the pid file and the cache file to ~/.cache/next\_background to respect the directory structure implied.

0.3
===
* Will now run through the file list and cache the values of various points, including md5 hash, WxH, ratio, and a few others.
* The generated list will get stored in a file in ~/.cache, this will aleviate long startup times.
* Stripped out all of the dir tricks I was using, now randomfiles are pulled from the new ImageList class, hardcoded to search for files with 16:9 ratio
* Added two new classes to support the above, Image and ImageList.
* ImageList supports a min amount of deduplication in the form that it will reconize a hash with multiple files and track them.

0.2.1
=====
* Added yardoc to the gem, currently can generate both yardoc and rdoc.
* Added some simple specs, not really finished or cleaned up.

cli.rb
------
* added --kill, to kill the currently running daemon.
* added --pid, to report the current pid (or nil) if none.

daemon.rb
---------
* added a options hash to @daemon, for configuration purposes.
* refactored @parent into a method call and changed how the daemon fires.
* added methods to report the current pid file.


0.2.0
=====

* mimics the behaviour of .1 perfectly. 
* refactored into an oop model instead of a single file.
* refactored to a single screen to continue development.

0.1.0
=====
* works on dual screens for spanning monitors.
* initial spike, a simple file to change a link every ten seconds and daemonize.
