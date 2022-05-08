class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    @items = Item.find(params[:id])
    redirect_to item_path(@items.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end
  
  private
  #編集中
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
