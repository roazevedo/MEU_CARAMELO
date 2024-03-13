class BookmarksController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_animal, only: [:index]

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id).includes(:animal)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to animals_path, notice: "Animal favoritado com sucesso!"
    else
      redirect_to animals_path, alert: "Falha ao favoritar o animal."
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      redirect_to animals_path, notice: "Animal excluído com sucesso!"
    else
      redirect_to animals_path, alert: "Falha ao excluir o animal."
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :animal_id)
  end

  # def set_animal
  #   @animal = Animal.find(params[:animal_id])
  # end
end
