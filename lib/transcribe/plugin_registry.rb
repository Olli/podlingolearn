
require "pathname"
module Transcribe
  class PluginRegistry
    @@plugins = []
    def initialize(plugin_directory = "plugins")
      @plugin_dir = File.join(__dir__, plugin_directory)
    end

    # initialize all plugins
    def initialize_plugins
      @@plugins.each do |plugin|
        plugin.new
      end
    end
    def load_plugins(directory = @plugin_dir)
      Pathname.new(directory).children.each do |file|
        require file.to_s if file.extname == ".rb"
      end
    end
    # register plugin
    def self.register(plugin)
      @@plugins << plugin
    end
    # show all plugins
    def plugins
      @@plugins
    end
  end
end
