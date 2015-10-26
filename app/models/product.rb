class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
end
