class BoardsController < ApplicationController
  def index
    if current_user
    	@boards = current_user.boards
    else
      redirect_to root_path
    end
  end

  def show
    if current_user.id == Board.find(params[:id]).user_id
    	@board = Board.find(params[:id])
    else
      flash[:alert] = "Permissions Error: It seems you are not authorized to view that page."
      redirect_to root_path
    end
    @selectedImages = Image.order("RANDOM()").limit(10)
   # @selectedImages.uniq!{|image| image.image_url.to_s.split('/')[-1]}
  
  end

  def new
  	@board = Board.new
  end

  def create
   # @board = Board.new(board_params)
   @board = current_user.boards.build(board_params)
    if @board.save
    	redirect_to @board, notice: 'Board successfully created!'
    else
    	flash[:alert] = "Error creating your Board, please try agian."
    	render :new
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if @board.destroy
      flash[:notice] = "Your vision board has been removed successfully."
      redirect_to root_path
    else
      flash[:alert] = "Error removing your vision board, please try again."
      render :show
    end
  end

  def update
  #  if Image.update_attributes(params.require(:image).permit(:imageUrl, :imagePrice, :board_id))
  #  	flash[:notice] = "Board Updated"
  #  	redirect_to @board
  #  else
  #  	flash[:error] = "Error occurred"
  #  	redirect_to = @board
  #  end
  end
  def edit
  end


private

    def board_params
      params.require(:board).permit(:name, :budget, :shared_link)
    end

end
