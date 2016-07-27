class Game < ActiveRecord::Base
  belongs_to :user #owner don't get confused
  has_and_belongs_to_many :attendees, class_name: 'User'
  default_scope -> { order(start: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
end
