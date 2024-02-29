class AdoptionFormsController < ApplicationController

  def index
    @adoption_forms = AdoptionForm.all
  end


  def show
    @adoption_form = AdoptionForm.find(params[:id])
  end


  def new
    @adoption_form = AdoptionForm.new
  end

  def create
    @adoption_form = AdoptionForm.new(adoption_form_params)
    @adoption_form.user = current_user
    if @adoption_form.save
      redirect_to @adoption_form
    else
      flash.now[:alert] = 'There was a problem creating the Adoption Form.'
      @errors = @adoption_form.errors.full_messages
      render 'new'
    end
  end

  def edit
    @adoption_form = AdoptionForm.find(params[:id])
  end

  def update
    @adoption_form = AdoptionForm.find(params[:id])
    if @adoption_form.update(adoption_form_params)
      redirect_to @adoption_form
    else
      flash.now[:alert] = 'There was a problem updating the Adoption Form.'
      @errors = @adoption_form.errors.full_messages
      render 'edit'
    end
  end

  private

  def adoption_form_params
    params.require(:adoption_form).permit(:query, :user_id, :pergunta1, :pergunta2, :pergunta3, :pergunta4, :pergunta5,
    :pergunta6, :pergunta7, :pergunta8)
  end
end
