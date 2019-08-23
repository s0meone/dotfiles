Dir[File.expand_path(File.join(`rbenv which ruby`.chomp, "../../**/lib"))].each { |dir| $:.unshift(dir) }

Pry.config.should_load_plugins = false
Pry.config.editor = "vim"
Pry.config.pager = false

# require 'awesome_print'
# AwesomePrint.pry!

def pry_prompt(target_self, nest_level, pry, prefix="-")
  view_clip = Pry.view_clip(target_self)

  app = defined?(Rails) && Rails.env ? ":#{Rails.application.class.name.deconstantize.underscore.dasherize}" : ""

  view_clip = "pry" if view_clip == "#<IRB::TopLevel>"
  nest_level = nest_level.zero? ? "" : ":#{nest_level}"
  "#{prefix}#{app}:#{view_clip}#{nest_level} $ "
end

Pry.prompt = [
  proc { |target_self, nest_level, pry|
    pry_prompt target_self, nest_level, pry
  },

  proc { |target_self, nest_level, pry|
    pry_prompt target_self, nest_level, pry, "+"
  }
]

if defined?(Rails) && Rails.env
  ActiveRecord::Base.logger = nil
  include Rails::ConsoleMethods rescue nil
end
