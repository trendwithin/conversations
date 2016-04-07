require 'test_helper'

class ChirpTest < ActiveSupport::TestCase
  def setup
    @chirp = chirps(:bill)
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
end
