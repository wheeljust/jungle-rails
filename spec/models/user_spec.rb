require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
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
  
    it "is not valid when the same email already exists" do
      @user1 = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "jungle123", password_confirmation: "jungle123")
      @user2 = User.create(first_name: "John", last_name: "Rogers", email: "JOHN@gmail.com", password: "jungle123", password_confirmation: "jungle123")
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      expect(@user2).to_not be_valid
    end
  
    it "is not valid when the password is not the minimum length" do
      @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "book", password_confirmation: "book")
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      expect(@user).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it "allows a user login when credentials are correct" do
      @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "jungleBook123", password_confirmation: "jungleBook123")
      expect(@user.authenticate_with_credentials("john@gmail.com", "jungleBook123")).to eql(@user)
    end

    it "allows a user login when email has white spaces or capital letters" do
      @user = User.create(first_name: "John", last_name: "Rogers", email: "John@gmail.com", password: "jungleBook123", password_confirmation: "jungleBook123")
      expect(@user.authenticate_with_credentials("   JOHN@gmail.com   ", "jungleBook123")).to eql(@user)
    end

    it "returns nil when the password is not valid" do
      @user = User.create(first_name: "John", last_name: "Rogers", email: "john@gmail.com", password: "jungleBook123", password_confirmation: "jungleBook123")
      expect(@user.authenticate_with_credentials("john@gmail.com", "john123")).to be(nil)
    end
    it "returns nil when the users email does not exist in the database yet" do
      @user = User.new(first_name: "Jeff", last_name: "Rogers", email: "jeff@gmail.com", password: "jungle34567", password_confirmation: "jungle34567")
      expect(@user.authenticate_with_credentials("jeff@gmail.com", "jungle34567")).to be(nil)
    end
  end
end
