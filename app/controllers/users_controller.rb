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
    if @user.save
      redirect_to @user
    else
      flash.now[:alert] = 'Tivemos um problema ao criar o usuário.'
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def find_matches(user)
    user_adopter = user.adopter.pluck(:name)
    matches = User.joins(:adopter).where(adopter: {name: user_adopter})

    scored_matches = matches.map do |match|
      shared_adopter = match.adopter.pluck(:name) & user_adopter
      {match: match, score: shared_adopter}
    end

    scored_matches.sort_by! { |match| -match[:score] }
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    else
      flash.now[:alert] = 'Tivemos um problema ao editar o usuário.'
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
