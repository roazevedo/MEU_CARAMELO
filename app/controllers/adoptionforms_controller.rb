require 'csv'
class AdoptionformsController < ApplicationController

  def show
    @adoption_form = AdoptionForm.find(params[:id])
  end

  def new
    @adoption_form = AdoptionForm.new
    @questions_and_answers = CSV.read(Rails.root.join('db','perguntas.csv'), liberal_parsing: true).map { |q, a| [q, a.split(';')] }.to_h
    end

  def create
    @adoption_form = AdoptionForm.new(adoption_form_params)
    @adoption_form.user = current_user
    answers = {}
    @questions_and_answers.keys.each do |question|
      answers[question] = params[question]
    end
    @adoption_form.query = answers
    if @adoption_form.save
      redirect_to @adoption_form
    else
      flash.now[:alert] = 'There was a problem creating the Adoption Form.'
      @errors = @adoption_form.errors.full_messages
      render 'new'
    end
  end

  def show
    @adoption_form = AdoptionForm.find(params[:id])
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
    params.require(:adoption_form).permit(:query, :user_id)
  end
end
