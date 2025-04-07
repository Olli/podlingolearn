class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[ show edit update destroy download_metadata_now ]
  before_action :get_episodes_job_status, only: [ :index, :show ]

  # GET /podcasts or /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts or /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)
    respond_to do |format|
      if @podcast.save
        SyncPodcastJob.perform_later(@podcast)
        format.html { redirect_to podcast_url(@podcast), notice: "Podcast was successfully created." }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to podcast_url(@podcast), notice: "Podcast was successfully updated." }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast.destroy!

    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: "Podcast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_metadata_now
    @podcast.episodes do |episode|
      GetEpisodeJob.perform_later(episode)
    end
    get_episodes_job_status
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    def get_episodes_job_status
      @getting_episodes = SolidQueue::Job.find_by(class_name: "GetEpisodesJob", finished_at: nil).present?
    end
    # Only allow a list of trusted parameters through.
    def podcast_params
      params.require(:podcast).permit(:name, :url, :xml_url, :active, :has_youtube)
    end
end
