class SidesController < ApplicationController
  load_and_authorize_resource

  def for_sectionid
    @subsections = SubSection.find( :all, :conditions => [" category_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }
    respond_to do |format|
      format.json  { render :json => @subsections }
    end
  end
  def index
    @category = Category.find(params[:category_id])
    @sides = @category.sides
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sides }

     end
  end

  def new
    @category = Category.find(params[:category_id])
    @side = @Category.sides.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @category.sides.create(side_params)
    redirect_to restaurant_categories_path(@restaurant)
  end

  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @side = @category.sides.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @side = @category.sides.find(params[:id])
    @side.update(side_params)

    redirect_to restaurant_categories_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @category = Category.find(params[:category_id])
    @side = @category.sides.find(params[:id])
    @side.destroy
    redirect_to restaurant_categories_path(@restaurant)
  end

  private
  def side_params
    params.require(:side).permit(:side_item,:details, :category_id)
  end
end
