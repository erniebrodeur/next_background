#!/usr/bin/ruby
require 'trollop'
require 'daemons'

@dir = "/home/ebrodeur/Pictures/1920x1080/"
@files = []
@file = ""
@single_link = "/home/ebrodeur/Pictures/single"

def get_random_file
  @files = Dir.glob("#{@dir}*")
  @file = @files[rand(@files.count)]
end

def cleanup_links
  if File.symlink?(@single_link)
    File.delete(@single_link)
  end
end

def create_link
  File.symlink @file, @single_link
end

def reload_desktop
  #xfce4, do a reload.
  %x[xfdesktop --reload]
end

def next_background
  get_random_file
  cleanup_links
  create_link
  reload_desktop
end

opts = Trollop::options do
  banner <<-EOS
This file will just create_split_links off a few creative links in my home directories.  Since you shouldn't
run it arbitrarily, you have to use options to make it work.

next_background [options]

Options:
where [options] are:
  EOS

  opt :daemon, "kick into daemon mode."
  opt :runonce, "change the links one time."
end

if opts[:daemon]
  Daemons.daemonize
  loop do
    next_background
    sleep 10
  end
  exit
elsif opts[:runonce]
  next_background
  exit
end

# shouldn't get here, at all.
puts "does not run without options.  Try --help."

