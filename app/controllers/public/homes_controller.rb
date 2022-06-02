class Public::HomesController < ApplicationController
  
  def top
    #reset_session
    @items = Item.limit(4).order("created_at DESC")
  end

  def about
  end
end
