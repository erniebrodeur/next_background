#!/usr/bin/ruby
require 'trollop'
require 'daemons'

@dir = "/home/ebrodeur/Pictures/random-directory/"
@files = Dir.glob("#{@dir}*.jpg")
@left_link = "/home/ebrodeur/Pictures/left"
@right_link = "/home/ebrodeur/Pictures/right"
@left_file = ""
@right_file = ""

def get_random_file
  file = @files[rand(@files.count)]
  @left_file = "#{file}0"
  @right_file = "#{file}1"
end

def gen_links
  if File.symlink?(@left_link)
    File.delete(@left_link)
  end

  if File.symlink?(@right_link)
    File.delete(@right_link)
  end
end

def fire
  File.symlink @left_file, @left_link
  File.symlink @right_file, @right_link
end

def reload_desktop
  #xfce4, do a reload.
  %x[xfdesktop --reload]
end

def next_background
  get_random_file
  gen_links
  fire
  reload_desktop
end

opts = Trollop::options do
  banner <<-EOS
This file will just fire off a few creative links in my home directories.  Since you shouldn't
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

