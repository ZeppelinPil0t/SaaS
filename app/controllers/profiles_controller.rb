class ProfilesController < ApplicationController
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
      redirect_to user_path(params[:user_id]) 
    else
      render action: :new
    end  
  end
  
  # GET to /users/:user_id/profiles/edit
  def edit
    @user = User.find( params[:user_id])
    @profile = @user.profile
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end