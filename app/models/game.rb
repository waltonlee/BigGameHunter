class Game < ActiveRecord::Base
  belongs_to :user #owner don't get confused
  belongs_to :gametype
  has_and_belongs_to_many :attendees, class_name: 'User'
  default_scope -> { order(start: :desc) }
  validates :user_id, presence: true
  validates :gametype_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :latitude, presence: true, numericality: { less_than: 42.4147205325, greater_than: 42.3943682535, message: " - Selected Location too far from Tufts" }
  validates :longitude, presence: true, numericality: { less_than: -71.1070599106, greater_than:  -71.132183075, message: " - Selected Location too far from Tufts" }
  validates :count, numericality: { only_integer: true }
  validates :need_count, numericality: { only_integer: true }
  validates :name, presence: true, length: {maximum: 50}
end
