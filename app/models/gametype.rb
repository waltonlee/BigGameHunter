class Gametype < ActiveRecord::Base
  has_many :games
  validates :name, presence: true, length: {maximum: 50}
  validates :image, presence: true
end
