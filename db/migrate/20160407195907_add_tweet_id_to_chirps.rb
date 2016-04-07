class AddTweetIdToChirps < ActiveRecord::Migration
  def change
    add_column :chirps, :tweet_id, :integer, limit: 8
  end
end
