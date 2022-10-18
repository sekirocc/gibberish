class Api::V1::GibbersController < ApplicationController

  PAGE_SIZE = 10

  def index
    @gibbers = Gibber.all
    render json: @gibbers
  end

  def show
    @gibber = Gibber.find(params[:id])
    render json: @gibber
  end

  def create
    @gibber = Gibber.new(gibber_params)
    if @gibber.save
      render json: @gibber
    else
      render json: { error: "cannot save gibber", status: 400 }
    end
  end

  def list_public
    cond = Gibber.is_public
    unless params[:since_id].nil? || params[:since_id] <= 0
      cond.where("id > ?", params[:since_id])
    end
    unless  params[:max_id].nil? || params[:max_id] <= 0
      cond.where("id < ?", params[:max_id])
    end

    @gibbers = cond.limit(PAGE_SIZE)
    render json: @gibbers
  end

  private
  def gibber_params
    params.require(:gibber).permit(
      :user_id,
      :content,
      :visibility,
    )
  end

end
