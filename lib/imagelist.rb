module NextBackground
  class FileError < StandardError
  end

  class ImageList
    # the main hash table of image objects
    attr_accessor :list

    def initialize
      Settings[:direcotry] = "/home/ebrodeur/Pictures/"
      Settings[:mask] = "**/*"
      @list = {}
      if File.exists? Settings[:cache_file]
        puts "cache exists in #{Settings[:cache_file]}, loading."
        load_cache
      else
        puts "cache doesn't exist, generating from #{Settings[:dir]}#{Settings[:mask]}"
        generate
        puts "saving #{@list.size} image(s) to #{Settings[:cache_file]}"
        save_cache
      end
    end

    # generate a new cache file
    def generate
      files = Dir.glob "#{Settings[:direcotry]}#{Settings[:mask]}"
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
      open(Settings[:cache_file], 'w').write @list.to_yaml
    end

    # load the cache file.
    def load_cache
      @list = YAML::load_file Settings[:cache_file]
    end

    # return a new list with the ratio provided, must be float (for now) with a 
    # 1.3 digit format
    # ie: 16:9 == 1.778
    def query_by_ratio(ratio)
      @list.select {|k,v| v.ratio == ratio}
    end

    # TODO: none of this works like you think, its a reference not a copy.
    # So when you do the following select! its pairing down the original list.
    # return the list of duplicates.
    def query_by_duplicates
      tmp = self.clone
      tmp.list = list.select {|k,v| v.filename.count > 1}
    end

    # return a random file that matches the input value.
    def randomfile_by_ratio(ratio)
      # ruby doesn't copy deep objects on a clone, only references.
      # So I have to restuff the trimmed down list into the new collection to use
      # the built in methods, probably a better way to do this..
      collection = self.clone
      collection.list = list.select{|k,v| v.ratio == ratio }
      # ruby trick here, I should make a 'random' object and do this right but oh well :)
      collection.files[Random::rand(collection.files.count)]
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
