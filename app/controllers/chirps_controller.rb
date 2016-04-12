class ChirpsController < ApplicationController

  def index
    @chirps = Chirp.within_twenty_four_hours.by_user_name.desc
  end
end
