class Animal < ApplicationRecord
  belongs_to :users
  has_many :adoptions
end
