class Follow < ActiveRecord::Base
  validates :name, presence: true
end
