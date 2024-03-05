class AdoptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:index, :new, :create,:show]
  before_action :set_adoption, only: [:show, :edit, :update, :done, :update_status, :done]

  def index
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
    @user = User.find(params[:user_id])
    @adoption = Adoption.new
  end

  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user = current_user # Atribuindo o usuário logado ao contrato
    @adoption.animal = @animal # Atribuindo o animal à adoção
    @adoption.status = 'Pending' # Definindo o status de aceitação da adoção
    @adoption.done = false # Definindo o status de conclusão do contrato
    # @new_adoption_created = true

    if @adoption.save
      redirect_to user_animal_adoption_path(user_id: @adoption.user.id, animal_id: @adoption.animal.id, id: @adoption.id), notice: 'adoption created successfully!'
    else
      render :new, status: :unprocessable_entity, notice: 'Unable to begin adoption.'
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
    @animal = Animal.find(params[:animal_id])
  end

  def set_adoption
    @adoption = Adoption.find(params[:id])
  end
end
