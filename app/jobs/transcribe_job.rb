class TranscribeJob < ApplicationJob
  queue_as :default

  def perform(episode)
    file = episode.audio_file
    return if file.blank?
    srtfile = nil
    episode.audio_file.blob.open do |tmpfile|
      srtfile = audio2text_process(tmpfile)
    end
    episode.srt_file.attach(io: srtfile,
                            filename: episode.title + ".srt",
                            content_type: "text/srt")
    episode.transcribed_at = DateTime.now
    episode.save


  end


  private
    def audio2text_process(tmpfile)
      Dir.chdir Rails.root + "vendor/audio2text"
      output_srt_tmp = Tempfile.new
      system("source .env/bin/activate")
      system("./audio2text.py --model-path ../whisper.cpp/models/#{Rails.configuration.audio2text['model']} -w ../whisper.cpp/main -i #{tmpfile.path} -o #{output_srt_tmp.path} -of srt")
      output_srt_tmp
    end
end
