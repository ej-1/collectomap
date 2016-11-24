class LayoutsController < ApplicationController

  def landing
    if current_user.nil?
      @lists = List.only_lists
      render :layout => 'landing'
    else
      redirect_to lists_url
    end
  end

end
