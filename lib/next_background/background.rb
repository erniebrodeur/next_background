module NextBackground
  class Background
    attr_accessor :link_file
    attr_accessor :directory

    def files
    	@@cache ||= Bini::Sash.new options:{file:"#{Bini.cache_dir}/files.json"}

    	# we don't have shit.  ain't shit to be had.
    	if !@@cache[directory]
    		@@cache[directory] = Dir.glob File.join(directory, "**", "*")
    		@@cache.save
    	end

    	@@cache[directory]
    end

    def initialize(params = {})
      @link_file = params[:link_file] if params[:link_file]
      @directory = params[:directory] if params[:directory]
    end

    def random_file
      @@random ||= Random.new

      return files[@@random.rand(0..files.count)]
    end

    def link_random_file
      if File.exist?(link_file)
        unless File.ftype(link_file) == "link"
          raise RuntimeError, "#{link_file} does not appear to be a link."
        else
          FileUtils.rm link_file
        end
      end


      FileUtils.ln_s random_file, link_file

      return true
    end

  end
end
