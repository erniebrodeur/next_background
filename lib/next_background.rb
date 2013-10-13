require 'bini'
require 'mini_magick'

require "next_background/background"
require "next_background/version"

module NextBackground
  extend self

  Jobs = Array.new

  def add_job(background)
    raise ArgumentError unless background.kind_of? NextBackground::Background

    puts "Found #{background.files.count} images for #{background.link_file} in #{background.directory}."
    Jobs.push background
  end

  def run_jobs
    while true
      Jobs.each do |job|
        job.link_random_file
      end
      `xfdesktop --reload`

      sleep 10
    end
  end
end
