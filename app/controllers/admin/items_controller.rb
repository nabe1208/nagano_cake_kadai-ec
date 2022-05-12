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
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
    @genre = @item.genre
  end

  def edit
    @item = Item.find(params[:id])
    @genre = @item.genre
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_items_path
  end

  private
  #編集中
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image)
  end
end

# admin_items_path -index,create
# new_admin_item_path -new
# edit_admin_item_path -edit
# admin_item_path -show,update(patch,put)
