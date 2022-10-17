class Api::V1::MurmursController < ApplicationController

  PAGE_SIZE = 10

  def index
    @murmurs = Murmur.all
    render json: @murmurs
  end

  def show
    @murmur = Murmur.find(params[:id])
    render json: @murmur
  end

  def create
    @murmur = Murmur.new(murmur_params)
    if @murmur.save
      render json: @murmur
    else
      render json: { error: "cannot save murmur", status: 400 }
    end
  end

  def list_public
    cond = Murmur.is_public
    unless params[:since_id].nil? || params[:since_id] <= 0
      cond.where("id > ?", params[:since_id])
    end
    unless  params[:max_id].nil? || params[:max_id] <= 0
      cond.where("id < ?", params[:max_id])
    end

    @murmurs = cond.limit(PAGE_SIZE)
    render json: @murmurs
  end

  private
  def murmur_params
    params.require(:murmur).permit(
      :user_id,
      :content,
      :visibility,
    )
  end

end
