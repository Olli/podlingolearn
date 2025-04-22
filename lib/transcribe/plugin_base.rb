# Basic plugin interface
module Transcribe::PluginBase
  # list of available plugins in format { "plugin name" => reference_to_class}
  def self.included(base)
    base.extend(ClassMethods)
    # @@config = ActiveSupport::OrderedOptions.new
    # base.instance_eval do
    #  @@config = ActiveSupport::OrderedOptions.new
    # end
    # Transcribe::PluginRegistry.register(base)
  end

  module ClassMethods
    # initialize plugin with @plugin_name
    # and description
    def self.plugin_name
      raise NotImplementedError, "Plugin need to have a name"
    end

    def lang=(l = "auto")
      @lang = l
    end
    def lang
      @lang || "auto"
    end

    def config
      # @config&.send(plugin_name.to_sym)
      @config
    end



    def format=(output_format = "web_vtt")
      @output_format = output_format
    end


    # get plaintext without everything
    def text
      raise NotImplementedError, "Method for getting text needed"
    end
    # get text in srt format
    def srt
      raise NotImplementedError, "Method for getting srt needed"
    end
    # get text in WebVTT format
    def web_vtt
      raise NotImplementedError, "Method for getting websrt needed"
    end

    def transcribe!(text)
      raise NotImplementedError,
              "A Speech2Text plugin must implement this method"
    end
  end
end
