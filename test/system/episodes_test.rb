require "application_system_test_case"

class EpisodesTest < ApplicationSystemTestCase
  setup do
    @episode = episodes(:one)
  end

  test "visiting the index" do
    visit episodes_url
    assert_selector "h1", text: "Episodes"
  end

  test "should create episode" do
    visit episodes_url
    click_on "New episode"

    check "Is youtube" if @episode.is_youtube
    fill_in "Podcast", with: @episode.podcast_id
    fill_in "Url", with: @episode.url
    click_on "Create Episode"

    assert_text "Episode was successfully created"
    click_on "Back"
  end

  test "should update Episode" do
    visit episode_url(@episode)
    click_on "Edit this episode", match: :first

    check "Is youtube" if @episode.is_youtube
    fill_in "Podcast", with: @episode.podcast_id
    fill_in "Url", with: @episode.url
    click_on "Update Episode"

    assert_text "Episode was successfully updated"
    click_on "Back"
  end

  test "should destroy Episode" do
    visit episode_url(@episode)
    click_on "Destroy this episode", match: :first

    assert_text "Episode was successfully destroyed"
  end
end
