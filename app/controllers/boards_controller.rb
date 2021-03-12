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
       @board = Board.new(board_params)
      if @board.save
         @boards = Board.all.order("created_at DESC")
      else
        render :new
      end
    end

    def update
      board = Board.find(params[:id])
      @boards = Board.all.order("created_at DESC")
      if board.update(board_params)
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