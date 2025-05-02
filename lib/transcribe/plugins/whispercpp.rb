# require "whisper.o"
require "open3"

module Transcribe::Plugins
  class Whispercpp
    include Transcribe::PluginBase
    def self.plugin_name
      "Whisper Speech2Text"
    end
    def initialize(config = ActiveSupport::OrderedOptions.new)
      @config = config
      setup
    end

    # transcribe the audio file
    # @params [String, #read] estring with full path
    # @returns the return code of system
    def transcribe!(audiofile_path)
      command = %w(
        @config.params.binary
        "--output-#{@config.params.output_format}"
        "--language auto"
        "--model #{@config.params.model_path + "/" + @config.params.model}"
        "--output-file #{output_file_path(audiofile_path)}"
        audiofile_path )
      # execute the commandline on whispercpp
      if system(command.join(" "))

        "#{output_file_path(audio_file_path)}.#{@config.params.output_format}"
      else
        raise TranscribeError
      end
    end



    private
    # remove the file extension from the input file
    def output_file_path(audiofile)
      path = File.dirname(audiofile)
      filename_without_ext = File.basename(audiofile, ".*")
      File.join(path, filename_without_ext)
    end
    # sets up all the parameters for the whispercpp cli
    def setup
      @config.params = ActiveSupport::OrderedOptions.new
      @config.params.binary =  "vendor/whisper.cpp/build/bin/whisper-cli"
      @config.params.model = "ggml-tiny.en.bin"
      @config.params.output_format = "vtt"
      @config.params.model_path = "vendor/whisper.cpp/models"
    end
  end
end

Transcribe::PluginRegistry.register(Transcribe::Plugins::Whispercpp)
