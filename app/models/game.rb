class Game < ActiveRecord::Base
  belongs_to :user #owner don't get confused
  belongs_to :gametype
  has_and_belongs_to_many :attendees, class_name: 'User'
  default_scope -> { order(start: :desc) }
  validates :user_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :name, presence: true, length: {maximum: 50}
end
