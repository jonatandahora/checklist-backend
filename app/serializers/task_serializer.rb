class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :finished, :priority
end
