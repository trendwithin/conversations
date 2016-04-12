require 'test_helper'
require 'json'

class ChirpTest < ActiveSupport::TestCase
  def setup
    @chirp = chirps(:bill)
    @file = File.read('test/fake/twitter_response.json')
    @user_timeline = JSON.parse(@file)
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
end
