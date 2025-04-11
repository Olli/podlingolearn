require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  def setup
    @podcast = Podcast.create(name: "Test Podcast")
    @episode = Episode.new(
      podcast: @podcast,
      url: "http://example.com/test"
    )
  end

  test "should be valid" do
    assert @episode.valid?
  end

  test "should require a podcast" do
    @episode.podcast = nil
    assert_not @episode.valid?
    assert_includes @episode.errors[:podcast], "must exist"
  end

  test "should have a unique url scoped to podcast" do
    duplicate_episode = @episode.dup
    @episode.save
    assert_not duplicate_episode.valid?
    assert_includes duplicate_episode.errors[:url], "has already been taken"
  end

  test "should attach audio file" do
    @episode.audio_file.attach(io: File.open(
                               Rails.root
                                 .join("test/fixtures/files/test_audio.mp3")),
                               filename: "test_audio.mp3")
    assert @episode.audio_file.attached?
  end

  test "should attach srt file" do
    @episode.srt_file.attach(io: File.open(
                             Rails.root
                               .join("test/fixtures/files/test_subtitle.srt")),
                             filename: "test_subtitle.srt")
    assert @episode.srt_file.attached?
  end
end
