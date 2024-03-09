class RegistrationsController < Devise::RegistrationsController
  def new
    if params[:adopter] == "true"
      @user = User.new(adopter: true)
    else
      @user = User.new
    end
  end

  protected

  def after_sign_up_path_for(resource)
    # Aqui você pode definir para onde o usuário será redirecionado após o registro
    # Por exemplo, você pode redirecioná-lo para a página de perfil do usuário:
    @user = User.find_by(id: current_user)
    if @user.adopter == true
      matchs_path
    else
      user_path(resource)
    end
  end
end
