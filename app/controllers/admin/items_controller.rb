class Admin::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
     redirect_to admin_item_path(@item.id), notice:"商品を1件登録しました"
    else
     redirect_to new_admin_item_path, notice:"情報が入力されていません"
    end
  end

  def show
    @item = Item.find(params[:id])
    @genre = @item.genre
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
  end
end

# admin_items_path -index,create
# new_admin_item_path -new
# edit_admin_item_path -edit
# admin_item_path -show,update(patch,put)
