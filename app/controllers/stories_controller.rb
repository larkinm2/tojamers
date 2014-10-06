class StoriesController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    # @user = User.find(params[:user_id])
  end

  def new
    @story = Story.new
    @user_id = session[:user_id]
  end

  def show
    @story = Story.find(params[:id])
    @current_user_email = @story.user.email
    @sessions_email = session[:user_email]
    ### attempt at a validation. the user can only edit the stories, delete, etc if they are logged in
    #we compare the user in session to the user in the URL (params)
    #something isn't working here, it's not always finding the params user???
    #disconnect between params id and session id?
    #it's a coincidence, only works because the first the pitches are directly related to first the users
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    story = Story.find(params[:id])
    story.update(story_params)
    redirect_to story_path(story)
  end

  def destroy
    story = Story.find(params[:id])
    user = story.user_id
    story.destroy
    redirect_to user_path(user)
  end

  def create
    user = User.find(params[:userid])
    story = Story.create(story_params)
    story.user = user
    story.save
    redirect_to user_path(user)
  end

  private

  def story_params
    params.require(:story).permit(:url, :description)
  end




end

