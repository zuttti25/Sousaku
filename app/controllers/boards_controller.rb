class BoardsController < ApplicationController
  
    def new
      @board = Board.new
    end
  
    def show
      @board = Board.find(params[:id])
    end
  
    def edit
      @board = Board.find(params[:id])
    end
  
    def create
      if Board.create(board_params)
         @boards = Board.page(params[:page]).per(5).order("created_at DESC")
        else
        render :new
      end
    end

  
    def update
      board = Board.find(params[:id])
      if board.update(board_params)
        redirect_to root_path
        flash[:notice] = "更新しました。"
      else
        render :edit
      end
    end
  
    def destroy
      @board = Board.find(params[:id])
      @board.destroy
      redirect_to root_path
    end
  
    private
  
    def board_params
      params.require(:board).permit(:title, :essential, :requirement, :address).merge(user_id: current_user.id)
    end
  
  end
