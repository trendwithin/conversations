class Chirp < ActiveRecord::Base
  validates :name, presence: true
  validates :text, presence: true

  scope :within_twenty_four_hours, -> { where(created_at: 24.hours.ago..DateTime.now) }
  scope :by_user_name, -> { order(name: :desc) }
  scope :desc, -> { order(created_at: :desc) }

  def Chirp.fetch_peeps
    @peeps = Peep.all
  end

  def Chirp.prepare
    self.fetch_peeps
    self.twitter unless Rails.env.test?
    self.fetch_tweets(@peeps, @twitter_client)
  end

  def Chirp.fetch_tweets(peeps, twitter_client)
    peeps.each do |user_name|
      begin
        if self.find_by(name: user_name.name.downcase).nil?
          twitter_client.user_timeline(user_name.name).take(1).collect do |tweet|
            self.save_tweet tweet
          end
        else
          twitter_client.user_timeline(user_name.name.downcase, since_id: maximum(:tweet_id)).each do |tweet|
            unless exists?(tweet_id: tweet.id)
              self.save_tweet tweet
            end
          end
        end
      rescue => e
      Rails.logger.error { "Error while fetching tweets for: #{user_name}, #{e.message} #{e.backtrace.join("\n")}" }
      nil
      end
    end
  end

  private
    def Chirp.twitter
      @twitter_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV['TWITTER_API_KEY_SECRET']
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV['TWITTER_SECRET_ACCESS_TOKEN']
      end
    end

    def Chirp.save_tweet tweet
      create!(
        tweet_id: tweet.id,
        name: tweet.user.screen_name.downcase,
        text: tweet.text,
        in_reply_to: tweet.in_reply_to_status_id,
        created_on: tweet.created_at,
      )
    end
end
