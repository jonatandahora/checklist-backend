class Task < ActiveRecord::Base
  attr_accessible :description, :finished, :priority
  validates_presence_of :description
end
