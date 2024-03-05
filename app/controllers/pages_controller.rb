class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @animals = Animal.all # ACRESCENTADO PARA TESTE
  end

  def dashboard
    @user = current_user
    @animals = Animal.all
    @adoptions = Adoption.all
    @testimonies = Testimony.all
  end
end
