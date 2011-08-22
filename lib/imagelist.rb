require 'yaml'
require 'mini_magick'
require './image.rb'
module ImageList
  class FileError < StandardError
  end

  class List
    # the dir we glob from
    attr_accessor :dir
    # the file mask used to glob
    attr_accessor :mask
    # the main hash table of image objects
    attr_accessor :list
    # our cache file
    attr_accessor :cache_file

    def initialize
      # bit of a catch 22 here, really you shouldn't edit this because it would never know.
      # the value in the save file gets completely ignored as well.
      @cache_file = "/home/ebrodeur/.cache/image_list.yaml"
      @dir = "/home/ebrodeur/Pictures/"
      @mask = "**/*"
      @list = {}
      if File.exists? @cache_file
        puts "cache exists in #{@cache_file}, loading."
        load_cache
      else
        puts "cache doesn't exist, generating from #{dir}#{mask}"
        generate
        puts "saving #{@list.size} image(s) to #{@cache_file}"
        save_cache
      end
    end

    # generate a new cache file
    def generate
      files = Dir.glob "#{@dir}#{@mask}"
      files.each do |f|
        if (!File.directory?(f)  && !File.symlink?(f))
          puts "processing #{f}"
          begin 
            i = Image.new f
            # this will skip anything that imagemagick doesn't like, GIGO
          rescue MiniMagick::Invalid
            puts "#{f} is not an image, skipping"
            next
          end

          if @list[i.md5]
            @list[i.md5].filename.push f
          else
            @list[i.md5] = i
          end
        end
      end
    end

    # save the current list to the cache
    def save_cache
      open("/home/ebrodeur/.cache/image_list.yaml", 'w').write self.to_yaml
    end

    # load the cache file, overwriting the current settings
    def load_cache
      tmp = YAML::load_file @cache_file
      @dir = tmp.dir
      @mask = tmp.mask
      @list = tmp.list
    end

    # return a new list with the ratio provided, must be float (for now) with a 
    # 1.3 digit format
    # ie: 16:9 == 1.778
    def query_by_ratio(ratio)
      @list.select {|k,v| v.ratio = ratio}
    end

    # return the list of duplicates.
    def query_by_duplicates
      tmp = self
      tmp.list.select! {|k,v| v.filename.count > 1}
      tmp
    end

    # return a list of files only, as an array
    def files
      array = []
      @list.each do |k,v|
        array += v.filename
      end
      array
    end
  end
end
