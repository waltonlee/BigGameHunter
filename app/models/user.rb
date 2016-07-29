class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  has_many :games, dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: 'Game'
  has_and_belongs_to_many :gametypes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
