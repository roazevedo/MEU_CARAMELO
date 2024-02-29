class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # If the user is saved successfully, redirect to the user's show page
    if @user.save
      redirect_to @user
    else
      # If the user isn't saved successfully, re-render the form so the user can fix the problems
      flash.now[:alert] = 'There was a problem creating the User.'
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @adoption_form = AdoptionForm.find_by(user_id:current_user.id)
    if @user.update(user_params)
      #if @adoption_form.blank?
        #redirect_to new_adoptionform_path
     # end
    else
      flash.now[:alert] = 'There was a problem updating the User.'
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :state, :phone,
                                 :age, :size, :gender, :vaccination, :neutered, :specie, :adopter, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at)
  end
end