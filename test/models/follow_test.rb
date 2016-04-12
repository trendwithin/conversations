require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  def setup
    @follow = follows(:chris)
  end

  test 'validates presence of name' do
    @follow.name = ''
    refute @follow.valid?
  end
end
