class UserMailer < ApplicationMailer
	def confirmation_email(user, token)
	    @user = user
	    @token = token
	    @url  =  UserMailer.default_url_options[:host] + '/users/password/edit?initial=true&reset_password_token=' + token 
	    mail(to: @user.email, subject: 'Tu cuenta en Global Media te está esperando')
	    
  	end

end
