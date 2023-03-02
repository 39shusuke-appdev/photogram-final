class UsersController < ApplicationController
  def index
    matching_users = User.all
    @list_of_users = matching_users.order(:username => :asc)
    render({ :template => "users/index.html.erb" })
  end

  def show
    the_user = params.fetch("user_name") 
    matching_user = User.where({ :username => the_user })
    @the_username = matching_user.at(0)

    @the_request = FollowRequest.last

    if session[:user_id] == nil
      redirect_to("/user_sign_in", { :alert => "You have to sign in first."} )
    else 
      render({ :template =>"users/show.html.erb"})
      # redirect_to("/users", { :alert => "You're not authorized for that."} )
    end
  end
end
