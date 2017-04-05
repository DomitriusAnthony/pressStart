class UsersController < ApplicationController
    def show
  		@user = User.find(params[:id])
      
      @post = Post.new
      @users = User.all
      @posts = Post.all
      @comment = Comment.new
      
      @followed = current_user.followed if signed_in?

  	end

    def create
      @post = User.find(current_user).posts.new
      @post.update_attributes(post_params)

      respond_to do |format|
          if @post.save
            format.html { redirect_to root_url, notice: 'Post was successfully created.' }
            format.json { render :show, status: :created, location: @post }
          else
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
    end

    def streams
      @users = User.all  

    end

  	def follow
    	current_user.follow!(User.find(params[:id]))

    	flash[:notice] = "Successfully followed user!"

   	 redirect_to user_path(User.find(params[:id]))
  	end

  	def destroy
    	Relationship.where(followed_id: params[:id], follower_id: current_user.id).destroy_all

    	flash[:notice] = "Successfully stopped following user!"

    	redirect_to user_path(User.find(params[:id]))
  	end
end
