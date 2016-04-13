class Peep < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
