class PeepsController < ApplicationController
  before_action :set_peep, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @peeps = Peep.all
  end

  def show
  end

  def new
    @peep = Peep.new
  end

  def edit
  end

  def create
    @peep = Peep.new(peep_params)

    respond_to do |format|
      if @peep.save
        format.html { redirect_to @peep, notice: 'Peep was successfully created.' }
        format.json { render :show, status: :created, location: @peep }
      else
        format.html { render :new }
        format.json { render json: @peep.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @peep.update(peep_params)
        format.html { redirect_to @peep, notice: 'Peep was successfully updated.' }
        format.json { render :show, status: :ok, location: @peep }
      else
        format.html { render :edit }
        format.json { render json: @peep.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @peep.destroy
    respond_to do |format|
      format.html { redirect_to peeps_url, notice: 'Peep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_peep
      @peep = Peep.find(params[:id])
    end

    def peep_params
      params.require(:peep).permit(:name)
    end
end
