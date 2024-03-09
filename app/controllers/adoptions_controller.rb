class AdoptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_adoption, only: [:show, :edit, :update, :done, :update_status, :done]
  before_action :set_animal, only: [:index, :new, :create,:show]

  def my_applications
    @adoption = Adoption.where('user_id = ? AND animal_id IN (?)', current_user.id, current_user.animals.pluck(:id))
  end

  def show
    # user_id = current_user.id
    @user = current_user
    @adopter_adoptions = Adoption.where(user_id: @user)
    @owner_adoptions = Adoption.where(animal_id: @animal)

    # Combine a adoção do adopter e do owner em uma única coleção
    @adoptions = @adopter_adoptions.or(@owner_adoptions)
  end

  def new
    @adoption = Adoption.new
  end

  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user = current_user # Atribuindo o usuário logado ao contrato
    @adoption.animal = @animal # Atribuindo o animal à adoção
    @adoption.status = 'Pendente' # Definindo o status de aceitação da adoção
    @adoption.done = false # Definindo o status de conclusão do contrato
    @adoption_created = true

    if @adoption.save
      redirect_to adoption_path(@adoption), notice: 'Adoção criada com sucesso!'
    else
      render :new, status: :unprocessable_entity, notice: 'Não foi possível criar a adoção.'
    end
  end

  def update_status
    @adoption.status = params[:status]

    if @adoption.save
      redirect_to dashboard_path(@adoption)
    else
      redirect_to user_animal_adoption_path(adoption.animal.id)
    end
  end

  def edit
    render :show
  end

  def update
    @adoption = Adoption.find(params[:id])
    new_status = params[:status] # 'accept' ou 'reject'

    if current_user.id == @adoption.animal.user_id # Verifica se o usuário logado é o dono do animal
      if @adoption.update(status: new_status)
        redirect_to dashboard_path(@adoption), notice: 'Adoption updated successfully.'
      else
        render :edit
      end
    else
      redirect_to dashboard_path(@adoption), notice: 'You are not permitted to change this agreement.'
    end
  end

  # Ação personalizada para marcar a adoção como concluída
  def done
    @adoption.done = true
    if @adoption.save
      redirect_to dashboard_path(@adoption)
    else
      redirect_to user_animal_adoption_path(adoption.animal.id)
    end
  end

  private

  def adoption_params
    params.require(:adoption).permit(:user_id, :animal_id, :date, :status, :done)
  end

  def set_animal
    animal_id = params[:animal_id] || @adoption&.animal_id
    @animal = Animal.find(animal_id)
  end

  def set_adoption
    @adoption = Adoption.find(params[:id])
  end
end
