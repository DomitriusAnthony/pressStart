class RegistrationsController < Devise::RegistrationsController
	private

		def sign_up_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
		end

		def account_update_params
			params.require(:user).permit(:fname, :lname, :username, :stream_username, :chat_url, :avatar, :email, :password, :password_confirmation, :current_password)
  		end
end