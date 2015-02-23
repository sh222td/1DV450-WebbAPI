class Event < ActiveRecord::Base
  has_many :users
  has_many :positions
  has_and_belongs_to_many :tags
end
