FactoryGirl.define do
  factory :task do |f|
    f.description "Sample Task"
    f.priority 1
    f.finished false
  end
end
