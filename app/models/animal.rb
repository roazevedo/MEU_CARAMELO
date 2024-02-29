class Animal < ApplicationRecord
  belongs_to :user
  has_many :adoptions

  # has_one_attached :photo
end
