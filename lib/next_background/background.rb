module NextBackground
  class Background
    attr_accessor :link_file
    attr_accessor :method

    def files
      send "by_#{method.keys.first}".to_sym, method.values
    end

    def initialize(params = {})
      @link_file = params[:link_file] if params[:link_file]
      @method = params[:method] if params[:method]
    end

    def random_file
      @@random ||= Random.new

      return files[@@random.rand(0..files.count-1)]
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

    def by_directory(value)
      return directory(value)
    end

    private
    def directory(dir)
      @@cache ||= Hash.new

      # we don't have shit.  ain't shit to be had.
      if !@@cache[dir]
        @@cache[dir] = Dir.glob File.join(dir, "**", "*")
      end

      return @@cache[dir]
    end
  end
end

