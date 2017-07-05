class Task < ActiveRecord::Base
  attr_accessible :description, :finished, :priority
end
