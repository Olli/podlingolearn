require "test_helper"

class PodcastEpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @podcast_episode = podcast_episodes(:one)
  end

  test "should get index" do
    get podcast_episodes_url
    assert_response :success
  end

  test "should get new" do
    get new_podcast_episode_url
    assert_response :success
  end

  test "should create podcast_episode" do
    assert_difference("PodcastEpisode.count") do
      post podcast_episodes_url, params: { podcast_episode: { is_youtube: @podcast_episode.is_youtube, podcast_id: @podcast_episode.podcast_id, url: @podcast_episode.url } }
    end

    assert_redirected_to podcast_episode_url(PodcastEpisode.last)
  end

  test "should show podcast_episode" do
    get podcast_episode_url(@podcast_episode)
    assert_response :success
  end

  test "should get edit" do
    get edit_podcast_episode_url(@podcast_episode)
    assert_response :success
  end

  test "should update podcast_episode" do
    patch podcast_episode_url(@podcast_episode), params: { podcast_episode: { is_youtube: @podcast_episode.is_youtube, podcast_id: @podcast_episode.podcast_id, url: @podcast_episode.url } }
    assert_redirected_to podcast_episode_url(@podcast_episode)
  end

  test "should destroy podcast_episode" do
    assert_difference("PodcastEpisode.count", -1) do
      delete podcast_episode_url(@podcast_episode)
    end

    assert_redirected_to podcast_episodes_url
  end
end
