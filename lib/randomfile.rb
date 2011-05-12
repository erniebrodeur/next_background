module NextBackground
  #
  # This will contain all the file management and file check and all related error
  # checking.  
  class RandomFile
    # 
    # This sets the base directory to get the file list from.
    attr_accessor :dir
    #
    # The link to be set, this is the file you tune your WM to watch.
    attr_accessor :link
    #
    # Our list of files, based on the @dir variable.
    attr_reader   :files
    #
    # Our random file, nil if no result is available for any reason.
    attr_reader   :file
   #
    # initialize can take one argument, dir.  If this argument is present, it will simply
    # set the dir, which in turn does the checks and the files.glob.
    def initialize(dir = nil)
      if dir
        self.dir=(dir)
      end
    end

    #
    # Manual control of our attr_write so we can glob files and check for the existance
    # of the directory.
    def dir=(dir)
      if !dir || !File.directory?(dir)
        raise "Directory does not exist or is not a directory: #{dir}"
      end
      @dir = dir
      # I'm sure I could do more checking here, but this should produce something most times.
      @files = Dir.glob("#{File.expand_path(dir)}/*")
      next_file
      self
    end      

    # 
    # generate a random file and store it inside the class, so we can refer to it as needed.
    def next_file
      @file = @files[rand(@files.count)]
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
    def set_link
      if !@file
        next_file
      end

      if !@link
        raise "Unable to continue, link is not configured."
      end
      clean_link
      File.symlink @file, @link
    end
  end
end

