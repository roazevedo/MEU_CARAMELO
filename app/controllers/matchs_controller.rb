class MatchsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.find_by(id: current_user)
    @animals = Animal.all
    @matches = []

    @animals.each do |animal|
      match_data = match(@user,  animal)
      if match_data && match_data[:score] > 0
        @matches << { animal: animal, match_data: match_data }
      end
    end
  end


  def match(user,  animal)
    @adoption = Adoption.find_by(animal_id: animal.id)
    if @adoption.status != 'Aceito' && user.specie == animal.specie
    match_data = {
      size_match: user.size == animal.size,
      specie_match: user.specie == animal.specie,
      gender_match: user.gender == animal.gender,
      age_match: user.age == animal.age,
      vaccination_match: user.vaccination == animal.vaccination,
      neutered_match: user.neutered == animal.neutered
    }
    match_data[:score] = match_data.values.count(true)

    end
    match_data
  end
end
