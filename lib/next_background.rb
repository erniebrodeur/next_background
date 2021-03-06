#!/usr/bin/ruby

# generics
require 'trollop'
require 'yaml'
require 'mini_magick'
require 'digest/md5'
require 'daemons'
require 'sys/proctable'

# internals
require 'configuration'
require 'randomfile'
require 'cli'
require 'clioptions'
require 'daemon'
require 'image'
require 'imagelist'

module NextBackground
end
