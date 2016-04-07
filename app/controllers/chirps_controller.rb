class ChirpsController < ApplicationController

  def index
    @chirps = Chirp.all
  end
end
