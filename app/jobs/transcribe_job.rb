class TranscribeJob < ApplicationJob
  queue_as :default

  def perform(episode)
    file = episode.audio_file
    return if file.blank?
    outputfile = nil
    episode.audio_file.blob.open do |tmpfile|
      outputfile = audio2text_process(tmpfile)
    end

    return if not outputfile

    episode.subtitle_file.attach(io: srtfile,
                            filename: episode.title + ".srt",
                            content_type: "text/srt")
    episode.transcribed_at = DateTime.now
    episode.save
  end


  private
  def audio2text_process(tmpfile)
    transscriber = Transcribe::Speech2Text.new
    transscriber.transcribe(tmpfile.path)
  end
end
