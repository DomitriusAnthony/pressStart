class InboxController < ApplicationController
	def inbox 
		session[:conversations] ||= []

		@users = User.all.where.not(id: current_user)
		@conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
	end

	
end
