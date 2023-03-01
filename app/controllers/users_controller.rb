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
    render({ :template =>"users/show.html.erb"})
  end
end
