require 'rails_helper'

RSpec.describe Task, :type => :model do
  it "is valid with valid attributes" do
    subject = FactoryGirl.build(:task)
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject = FactoryGirl.build(:task, description: nil)
    expect(subject).to_not be_valid
  end
end
