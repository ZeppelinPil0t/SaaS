class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form_form
    @profile = Profile.new
  end
  
  # POST to /user/:user_in/profile
  def create
    @user = User.find( params[:user_id])
    # Ensure we have the user who is filling out form
    @profile = @user.build_profile( profile_params )
    #Create profile linked to this specific user
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_to user_path(id: params[:user_id]) 
    else
      render action: :new
    end  
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id])
    @profile = @user.profile
  end
  
  # PUT to /users/:user_id/profile
  def update
    #Retrieve user from datatbase
    @user = User.find( params[:user_id])
    #retrieve user profile
    @profile = @user.profile
    # Mass assign edited profile attributes
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated"
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :edit
    end  
  end  

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end