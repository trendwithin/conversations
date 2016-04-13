require 'test_helper'

class PeepTest < ActiveSupport::TestCase
  def setup
    @peep = peeps(:chris)
  end

  test 'presence of name' do
    @peep.name = ''
    refute @peep.valid?
  end

  test 'prevents duplicate names' do
    dupe = @peep.dup
    refute dupe.valid?
  end
end
