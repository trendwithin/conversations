require 'test_helper'
require 'json'

class ChirpTest < ActiveSupport::TestCase
  def setup
    @chirp = chirps(:bill)
    @file = File.read('test/fake/twitter_response.json')
    @parsed = JSON.parse(@file)
  end

  test 'presence of name' do
    @chirp.name = ''
    refute @chirp.valid?
  end

  test 'presence of text' do
    @chirp.text = ''
    refute @chirp.valid?
  end

  test 'empty in_reply_to is valid' do
    assert @chirp.valid?
    @chirp.in_reply_to = ''
    assert @chirp.valid?
  end

  test '#fetch_peeps pulls a list of Peeps' do
    peeps = Chirp.fetch_peeps
    assert_equal peeps.length, 2
    assert peeps.include? peeps(:bill)
    assert peeps.include? peeps(:chris)
  end

  test '#save_tweet for valid format' do
    @new_chirp = Chirp.create!( name: 'jenny', text: 'Who can I turn to?', created_on: Time.now, tweet_id: 8675309 )
    @new_chirp.reload
    assert Chirp.find(@new_chirp.id)
  end

  test '#save_tweet prevents duplicates' do
    @new_chirp = Chirp.create!( name: 'jenny', text: 'Who can I turn to?', created_on: Time.now, tweet_id: 8675309 )
    @new_chirp.reload
    dup = @new_chirp.dup
    dup.save unless Chirp.exists?(tweet_id: dup.id)
  end

end
