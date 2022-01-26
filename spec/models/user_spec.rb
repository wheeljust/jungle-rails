require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid when all fields are provided correctly" do
    @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "jungle123", password_confirmation: "jungle123")
    expect(@user).to be_valid
  end

  it "is not valid without a first name" do
    @user = User.create(first_name: nil, last_name: "Rogers", email: "john@gmail.com", password: "jungle123", password_confirmation: "jungle123")
    expect(@user.errors.full_messages).to include("First name can't be blank")
    expect(@user).to_not be_valid
  end

  it "is not valid without a last name" do
    @user = User.create(first_name: "John", last_name: nil, email: "john@gmail.com", password: "jungle123", password_confirmation: "jungle123")
    expect(@user.errors.full_messages).to include("Last name can't be blank")
    expect(@user).to_not be_valid
  end

  it "is not valid without an email" do
    @user = User.create(first_name: "John", last_name: "Rogers", email: nil, password: "jungle123", password_confirmation: "jungle123")
    expect(@user.errors.full_messages).to include("Email can't be blank")
    expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
    @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: nil, password_confirmation: nil)
    expect(@user.errors.full_messages).to include("Password can't be blank")
    expect(@user).to_not be_valid
  end

  it "is not valid without a MATCHING password" do
    @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "jungle123", password_confirmation: "book123")
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    expect(@user).to_not be_valid
  end



end
