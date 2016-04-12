class Chirp < ActiveRecord::Base
  validates :name, presence: true
  validates :text, presence: true

  scope :within_twenty_four_hours, -> { where(created_at: 24.hours.ago..DateTime.now) }
  scope :by_user_name, -> { order(name: :desc) }
  scope :desc, -> { order(created_at: :desc) }


  def Chirp.twitter
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV['TWITTER_API_KEY_SECRET']
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV['TWITTER_SECRET_ACCESS_TOKEN']
    end
  end

  def Chirp.fetch_peeps
    @peeps = Peep.all
    self.fetch_tweets @peeps
  end

  def Chirp.fetch_tweets peeps
    self.twitter unless Rails.env.test?
    peeps.each do |user_name|
      if self.find_by(name: user_name.name).nil?
        @twitter_client.user_timeline(user_name.name).take(1).collect do |tweet|
          self.save_tweet tweet
        end
      else
        @twitter_client.user_timeline(user_name.name, since_id: maximum(:tweet_id)).each do |tweet|
          unless exists?(tweet_id: tweet.id)
            self.save_tweet tweet
          end
        end
      end
    end
  end

  private
    def Chirp.save_tweet tweet
      create!(
        tweet_id: tweet.id,
        name: tweet.user.screen_name,
        text: tweet.text,
        in_reply_to: tweet.in_reply_to_status_id,
        created_on: tweet.created_at,
      )
    end
end
