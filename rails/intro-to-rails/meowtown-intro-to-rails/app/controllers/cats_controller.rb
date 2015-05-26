class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    @cat.lose_a_life!
  end

  def new
    @cat = Cat.new # hack
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_path(@cat)
    else
      render 'new', status: 400
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to @cat
    else
      render 'edit', status: 400
    end
  end

  private

    def cat_params
      params.require(:cat).permit(:name, :life_story, :image_url)
    end

end