class Game < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(start: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 50}
end
