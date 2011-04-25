#!/usr/bin/ruby

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

loop do
  gen_links
  fire
  reload_desktop
  get_random_file
  sleep 10
end