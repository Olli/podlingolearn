class Transcribe::TranscribeError < StandardError
  def initialize(msg = "something did gone wrong while try to transcribe")
    super(msg)
  end
end
