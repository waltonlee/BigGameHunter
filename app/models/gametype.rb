class Gametype < ActiveRecord::Base
  has_many :games, :dependent => :delete_all
  has_and_belongs_to_many :users
  validates :name, presence: true, length: {maximum: 50}
  validates :image, presence: true
  default_scope {order('name ASC')}

end
