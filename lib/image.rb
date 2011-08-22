require 'digest/md5'
require 'mini_magick'

module ImageList
  class Image
    attr_accessor :filename
    attr_accessor :width
    attr_accessor :height
    attr_accessor :ratio
    attr_accessor :type
    attr_accessor :md5

    def md5_hash(string)
      Digest::MD5.hexdigest(string)
    end

    def initialize(filename)
      string = open(filename).read
      image = MiniMagick::Image.read string
      @filename = [filename]
      @md5 = md5_hash(string)
      # I discovered that this lib calls image magick each time you do a 'format' command
      # This way, I only call it one time to get the information I need and then do some quick
      # data processing to shape it.
      @height, @width, @type = image["%h %w %m"].split(" ")
      @height = @height.to_f
      @width = @width.to_f
      # lets make a ratio and limit it to 3 places.
      @ratio = @width / @height
      @ratio = @ratio.round(3)
    end
  end
end 
