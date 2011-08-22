module NextBackground
  #
  # This will contain all the file management and file check and all related error
  # checking.  
  class RandomFile
    #
    # The link to be set, this is the file you tune your WM to watch.
    attr_accessor :link
    # our currently linked file
    attr_accessor :file
    attr_accessor :imagelist

    def initialize
      @imagelist = ImageList.new
    end

    # 
    # generate a random file and store it inside the class, so we can refer to it as needed.
    def next_file
      @file = @imagelist.randomfile_by_ratio(1.778)
    end

    # 
    # Check if the link exists, and if it does delete
    def clean_link
      if File.symlink?(@link)
        File.delete(@link)
      end
    end

    #
    # set our link to a generated random file.  It will try its best to produce a link, including
    # calling next_file if it has not been called yet.
    def set(set_next = true)
      if !@file
        next_file
      end

      if !@link
        raise "Unable to continue, link is not configured."
      end
      
      clean_link
      File.symlink @file, @link

      if set_next
        next_file
      end
    end
  end
end
