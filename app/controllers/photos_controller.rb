class PhotosController < ApplicationController

  def add_likes
    l = Like.new
    l.fan_id = session[:user_id]
    l.photo_id = params.fetch("query_photo_id")
    l.save
    
    redirect_to("/photos", { :notice => "Like created successfully"})
  end

  def delete_likes
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end



  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photos/index.html.erb" })
  end

  def show

    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    @the_photo = matching_photos.at(0)

    
    matching_comments = Comment.all
    @list_of_comments = matching_comments.where({ :photo_id => the_id})

    if session[:user_id] == nil
      redirect_to("/user_sign_in", { :alert => "You have to sign in first."} )
    else
       render({ :template => "photos/show.html.erb" })
    end
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params.fetch("query_caption")
    # the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.image = params.fetch("query_image")
    # the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = @current_user.id

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.caption = params.fetch("query_caption")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.image = params.fetch("query_image")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = params.fetch("query_owner_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
