class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication, notice: "Thanks for signing in!"
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    oauth_info = request.env['omniauth.auth'].to_hash
    @user = User.find_for_twitter(oauth_info)

     sign_in_and_redirect @user, event: :authentication, notice: "Thanks for signing in!"

    # render text: "request.env['omniauth.auth']: #{request.env['omniauth.auth'].to_hash}
    #               >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    #               >>>>>>> XXXXXXXX: #{request.env['omniauth.auth'].to_hash["uid"]}"
  end

end