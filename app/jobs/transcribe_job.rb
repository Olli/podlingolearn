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
    transscriber = Speech2Text.new
    transscriber.transscribe!(tmpfile)
  end
end
