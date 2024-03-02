class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    # Aqui você pode definir para onde o usuário será redirecionado após o registro
    # Por exemplo, você pode redirecioná-lo para a página de perfil do usuário:
    @user = User.find(resource.id)
    if @user.adopter == true
      new_adoption_form_path
    else
      user_path(resource)
    end
  end
end
