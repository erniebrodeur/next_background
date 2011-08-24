#!/usr/bin/ruby

# generics
require 'trollop'
require 'yaml'
require 'mini_magick'
require 'digest/md5'
require 'daemons'

# internals
require 'randomfile'
require 'cli'
require 'clioptions'
require 'daemon'
require 'image'
require 'imagelist'

module NextBackground
end
