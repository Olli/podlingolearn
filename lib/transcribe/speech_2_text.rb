require "zeitwerk"
require "active_support"
require "streamio-ffmpeg"
module Transcribe
  class Speech2Text
    def initialize
      # setup_plugin_loading
      @config = ActiveSupport::OrderedOptions.new
      @plugin_registry  = PluginRegistry.new
      @plugin_registry.load_plugins
      @plugin_registry.initialize_plugins
      # @plugin_registry.plugins.each do |plugin|
      #   puts "Load test2audio plugin: #{plugin_class.plugin_name}"
      #   return  { plugin_class.plugin_name => plugin.new(@config) }
      # end
    end

    # runs the enabled plugin
    # @params [File,:read]  takes the file which should be transcribed
    def transcribe(audiofile)
      # @plugin_registry.plugins.first.new
      converted_audio = convert_audio(audiofile.to_path)
      run_plugin(converted_audio)
    end

    private
    # converts the audiofile to a wav if neccesary
    # @params [String,:read] path to audiofile
    # @returns [File] Fileobject tot he temporary audiofile
    def convert_audio(audiofile_path)
      tmp_audio = Tempfile.new("audiotranscription")
      audiofile = FFMPEG::Movie.new(audiofile_path)
      if audiofile.valid?
        # audio codec pcm_s16le
        # audio channels 2
        # audio rate 44100
        # format wav
        trancoder_options = %w[ -codec:a pcm_s16le
                                -ac 2
                                -ar 44100
                                -f wav]

        audiofile.transcode(tmp_audio.path, trancoder_options)

      end
      tmp_audio
    end
    # for now only run the first plugin because
    # it's not clear how to handle the return text yet
    def run_plugin(audiofile, plugin_name = nil)
      plugin_name ||= @plugin_registry.plugins.first.to_s
      transcription_service = @plugin_registry.plugins.first.new
      transcription_service.transcribe!(audiofile.to_path)
    end

    def setup_plugin_loading
      loader = Zeitwerk::Loader.new
      loader.push_dir("lib/transcribe/plugins")
      loader.enable_reloading()
      loader.setup
    end
  end
end
