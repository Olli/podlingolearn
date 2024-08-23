require "application_system_test_case"

class PodcastEpisodesTest < ApplicationSystemTestCase
  setup do
    @podcast_episode = podcast_episodes(:one)
  end

  test "visiting the index" do
    visit podcast_episodes_url
    assert_selector "h1", text: "Podcast episodes"
  end

  test "should create podcast episode" do
    visit podcast_episodes_url
    click_on "New podcast episode"

    check "Is youtube" if @podcast_episode.is_youtube
    fill_in "Podcast", with: @podcast_episode.podcast_id
    fill_in "Url", with: @podcast_episode.url
    click_on "Create Podcast episode"

    assert_text "Podcast episode was successfully created"
    click_on "Back"
  end

  test "should update Podcast episode" do
    visit podcast_episode_url(@podcast_episode)
    click_on "Edit this podcast episode", match: :first

    check "Is youtube" if @podcast_episode.is_youtube
    fill_in "Podcast", with: @podcast_episode.podcast_id
    fill_in "Url", with: @podcast_episode.url
    click_on "Update Podcast episode"

    assert_text "Podcast episode was successfully updated"
    click_on "Back"
  end

  test "should destroy Podcast episode" do
    visit podcast_episode_url(@podcast_episode)
    click_on "Destroy this podcast episode", match: :first

    assert_text "Podcast episode was successfully destroyed"
  end
end
