require "open-uri"
module PodcastActions
  class Sync
    PERMIT_IMAGE_FORMAT = %w[mp3 ogg].freeze
    class << self
      def sync_podcast(podcast)
        if podcast.xml_url.blank?
          podcast_site =  Nokogiri::HTML5(HTTParty.get(podcast.url).body)
          rss_feed = podcast_site.xpath("//html/head/link[@type='application/rss+xml']/@href").to_s
          podcast.xml_url = rss_feed
          podcast.save
        end
        if podcast.xml_url.present?
          xml = HTTParty.get(podcast.xml_url).body
          content = Feedjira.parse(xml)
          if podcast.image.blank?
            p "Saved Image for Podcast"
            uri = URI.parse(content.image.url)
            imagefile = uri.open
            image_mime = Mime::Type.lookup_by_extension(File.extname(content.image.url).delete("."))
            imagefile_name = File.basename(content.image.url)
            podcast.image.attach(io: imagefile, filename: imagefile_name, content_type: image_mime.to_s)
          end

          content.entries.each do |entry|
            local_episode = podcast.episodes.where(title: entry.title).first_or_initialize
            local_episode.update(content: entry.content,
                                author: entry.itunes_author,
                                url: entry.enclosure_url,
                                published: entry.published)
            p "Synced Entry - #{entry.title}"
          end
          p "Synced Feed - #{podcast.name}"
        end
      end

      def download_episode(episode)
        actions = self.new
        actions.download_episode_audio(episode)
      end
    end

    def download_episode_audio(episode, download_again = false)
      audiofile_url = episode.url

      valid_audio_format = get_content_type(audiofile_url)
      return unless valid_audio_format
      # return if no file is attached or no force_download is set
      return unless episode.audio_file.blank? or download_again


      uri = URI.parse(audiofile_url)
      audiofile = uri.open
      audiofile_name = File.basename(audiofile_url)
      episode.audio_file.attach(io: audiofile,
                                filename: audiofile_name,
                                content_type: valid_audio_format)
    end

    private
      def get_content_type(audiofile_url)
        ext_name = File.extname(audiofile_url).delete(".")
        return unless PERMIT_IMAGE_FORMAT.include?(ext_name)

        "audio/#{ext_name}"
      end
  end
end
