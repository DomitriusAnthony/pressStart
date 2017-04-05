class CommentsController < ApplicationController

  # Runs private methods defined lower before certain actions, in order to DRY up code
  # before_action :find_post, only: [:new, :create, :edit, :update, :destroy]
  # before_action :find_comment, only: [:edit, :update, :show, :destroy]

  # New action for creating comment
  def new
    @comment = Comment.new
  end

  # Create action for new comment
  def create
    @comment = Post.find(:post_id).comments.new
    @comment.update_attributes(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @comment = current_user.comments.create(comment_params)
    if @comment
      flash[:notice] = "Your comment was created successfully"
      redirect_to post_path Post.find(@comment.post_id)
    else
      flas[:alert] = "There was a problem saving your comment."
      redirect_to new_comment_path
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = "Successfully deleted comment!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error deleting comment!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, current_user, :post_id)
    end

end
