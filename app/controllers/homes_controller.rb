class HomesController < ApplicationController

  def top
    @boards = Board.all
  end



end
