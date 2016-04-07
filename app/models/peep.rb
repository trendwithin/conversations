class Peep < ActiveRecord::Base
  validates :name, presence: true
end
