class InboxController < ApplicationController
	def inbox 
		session[:conversations] ||= []

		@users = User.all.where.not(id: current_user)
		@conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
		@followed = current_user.followed if signed_in?
	end

	
end
