class TranscribeJob < ApplicationJob
  queue_as :default

  def perform(episode)
    file = episode.audio_file
    return if file.blank?
    srtfile = nil
    episode.audio_file.blob.open do |tmpfile|
      srtfile = audio2text_process(tmpfile)
    end
    if srtfile
      episode.srt_file.attach(io: srtfile,
                              filename: episode.title + ".srt",
                              content_type: "text/srt")
      episode.transcribed_at = DateTime.now
      episode.save
    else
      false
    end

  end


  private
    def audio2text_process(tmpfile)
      Dir.chdir Rails.root + "vendor/audio2text"
      output_srt_tmp = Tempfile.new
      #systemreturn = system("python -m venv .env ")
      #systemreturn = system("source .env/bin/activate")
      #systemreturn = system("./audio2text.py --model-path ../whisper.cpp/models/#{Rails.#configuration.audio2text['model']} -w ../whisper.cpp/main -i #{tmpfile.path} -o {output_srt_tmp.path} -of srt")
      exec_string = ".env/bin/python ./audio2text.py --model-path ../whisper.cpp/models/#{Rails.configuration.audio2text['model']} -w ../whisper.cpp/main -i #{tmpfile.path} -o #{output_srt_tmp.path} -of srt"

      logger.debug(exec_string)

      systemreturn = system(exec_string)

      systemreturn ? output_srt_tmp : systemreturn
    end
end
