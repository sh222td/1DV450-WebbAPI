class Position < ActiveRecord::Base
  
  belongs_to :event
  
  #reverse_geocode_by :latitude, :longitude
  #after_validation :reverse_geocode
  
end
