class ApartmentInfo < ActiveRecord::Base
  attr_accessible :address, :number, :owner
  belongs_to :user
end
