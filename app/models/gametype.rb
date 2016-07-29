class Gametype < ActiveRecord::Base
  has_many :games #dependent: destroy? maybe?
  has_and_belongs_to_many :users
  validates :name, presence: true, length: {maximum: 50}
  validates :image, presence: true

end
