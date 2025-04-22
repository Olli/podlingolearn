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
      @config.model ||= "tiny"
      setup
    end

    def transcribe!(audiofile)
      # @whisper.transcribe(audiofile, @config.params)
      url = URI("http://#{@config.params.http_host}:#{@config.params.http_port}/inference")
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url)
      request["Accept"] = @config.params.format_mime
      form_data = [ [ "file",
        File.open(audiofile) ], [ "response_format", @config.params.response_format ] ]
      request.set_form form_data, "multipart/form-data"
      response = http.request(request)
      response.read_body
    end



    private
    def setup
      # @whisper = Whisper::Context.new(@config.model)
      # @config.params = Whisper::Params.new
      @config.params = ActiveSupport::OrderedOptions.new
      @config.params.http_host = "localhost"
      @config.params.http_port = "8080"
      @config.params.format_mime = "application/srt"
      @config.params.response_format = "vtt"
    end
  end
end

Transcribe::PluginRegistry.register(Transcribe::Plugins::Whispercpp)
