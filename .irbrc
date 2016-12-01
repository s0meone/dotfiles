Dir[File.expand_path(File.join(`rbenv which ruby`.chomp, "../../**/lib"))].each { |dir| $:.unshift(dir) }

def load_irbrc(path)
  return if ['/', ENV['HOME']].include?(path)
  load_irbrc File.dirname(path)
  irbrc = File.join(path, '.irbrc')
  load(irbrc) if File.exists?(irbrc)
end
load_irbrc(Dir.pwd)

require 'pry'

if defined? ::Pry
  Pry.start
  exit
end
