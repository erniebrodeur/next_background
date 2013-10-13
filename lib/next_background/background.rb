module NextBackground
  class Background
    attr_accessor :link_file
    attr_accessor :directory
    attr_accessor :method

    def files
      if !method
        return by_directory
      else
        send "by_#{method.keys.first}".to_sym
      end
    end

    def initialize(params = {})
      @link_file = params[:link_file] if params[:link_file]
      @directory = params[:directory] if params[:directory]
      @method = params[:method] if params[:method]

      # we only want to setup @@cache one time no matter what since load is
      # destructive.
      unless NextBackground::Background.class_variables.include? :@@cache
        @@cache = Bini::Sash.new(options:{file:File.join(Bini.cache_dir,"files.json")})
        @@cache.load #try a load.
      end
    end

    def random_file
      @@random ||= Random.new

      return files.keys[@@random.rand(0..files.keys.count-1)]
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

    def by_directory
      return cache_dir
    end

    def by_ratio
      min_ratio = method[:ratio] - (method[:ratio] * 0.05)
      max_ratio = method[:ratio] + (method[:ratio] * 0.05)

      return cache_dir.select do |file, values|
        values[:ratio] > min_ratio && values[:ratio] < max_ratio
      end
    end

    private
    def cache_dir
      # we don't have shit.  ain't shit to be had.
      if !@@cache[directory]
        puts "Caching directory: #{directory}"
        @@cache[directory] = {}
        Dir.glob(File.join(directory, "**", "*")).each do |file|
          next unless File.file? file
          print "."
          begin
            image = MiniMagick::Image.open file
          rescue
            puts "\nSkipping #{file}."
            next
          end
          height, width, type = image["%h %w %m"].split(" ")
          height = height.to_f
          width = width.to_f
          # lets make a ratio and limit it to 3 places.
          ratio = width / height
          ratio = ratio.round(2)
          @@cache[directory][file] = {
            height:height,
            width:width,
            ratio:ratio,
            type:type
          }

        end
        puts "Finished caching #{directory}, found #{files.count} images."
      end

      @@cache.save
      return @@cache[directory]
    end
  end
end

