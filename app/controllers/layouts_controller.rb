class LayoutsController < ApplicationController

  def landing
    if current_user.nil?
      @lists = List.all
      render :layout => 'landing'
    else
      redirect_to lists_url
    end
  end

end
