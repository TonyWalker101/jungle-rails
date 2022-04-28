require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    context "when all fields are provided" do
      it "should create User" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")

        @user.save

        expect(@user.id).to be_present
      end
    end

    context "when one of the passwords don't match" do
      it "should not create User" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "pw")

        @user.save

        expect(@user.id).to be_nil
      end
    end

    context "when one of the passwords aren't provided" do
      it "should not create User" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: nil)

        @user.save

        expect(@user.id).to be_nil
      end
    end

    context "when an email is already in the db" do
      it "should not create User" do
        @user_1 = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")
        
        @user_1.save

        @user_2 = User.new(first_name: "Bob", last_name: "Ross", email: "EMAIL@EMAIL.COM", password: "password", password_confirmation: "password")

        @user_2.save

        expect(@user_1.id).to be_present
        expect(@user_2.id).to be_nil
      end
    end

    context "when an email isn't provided" do
      it "should not create User" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: nil, password: "password", password_confirmation: "password")
        
        @user.save

        expect(@user.id).to be_nil
      end
    end

    context "when a first name isn't provided" do
      it "should not create User" do
        @user = User.new(first_name: nil, last_name: "Walker", email: "email", password: "password", password_confirmation: "password")
        
        @user.save

        expect(@user.id).to be_nil
      end
    end

    context "when a last name isn't provided" do
      it "should not create User" do
        @user = User.new(first_name: "Tony", last_name: nil, email: "email", password: "password", password_confirmation: "password")
        
        @user.save

        expect(@user.id).to be_nil
      end
    end

    context "when a password is less than 5 characters long" do
      it "should not create User" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email", password: "pw", password_confirmation: "pw")
        
        @user.save

        expect(@user.id).to be_nil
      end
    end

  end

  describe ".authenticate_with_credentials" do

    context "when user credentials are correct" do
      it "should return a user object" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")

        @user.save

        valid_user = User.authenticate_with_credentials("email@email.com", "password")

        expect(valid_user).to eql(@user)

      end
    end

    context "when user credentials are correct but there are trailing spaces" do
      it "should return a user object" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")

        @user.save

        valid_user = User.authenticate_with_credentials(" email@email.com ", "password")

        expect(valid_user).to eql(@user)

      end
    end

    context "when user credentials are correct but the email casing is wrong" do
      it "should return a user object" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")

        @user.save

        valid_user = User.authenticate_with_credentials(" EmAiL@EmAiL.coM ", "password")

        expect(valid_user).to eql(@user)

      end
    end

    context "when user credentials are incorrect" do
      it "should return nil" do
        @user = User.new(first_name: "Tony", last_name: "Walker", email: "email@email.com", password: "password", password_confirmation: "password")

        @user.save

        valid_user = User.authenticate_with_credentials("email@email.com", nil)

        expect(valid_user).to be_nil

      end
    end
  end

end
