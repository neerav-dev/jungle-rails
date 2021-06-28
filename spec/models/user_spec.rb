require 'rails_helper'
require 'pp'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    # create use when all field are supplied and password and confirm password matches
    it("should create user when all field are supplied and password and confirm password matches") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to be_valid
    end


    # email must be required
    it("should not create user when email is blank") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages.first).to eq("Email can't be blank")
    end

    # first name must be required
    it("should not create user when first name is blank") do
      user = User.new(
        lastname: "patel",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages.first).to eq("Firstname can't be blank")
    end

    # last name must be required
    it("should not create user when last name is blank") do
      user = User.new(
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages.first).to eq("Lastname can't be blank")
    end
    
    # password must be required
    it("should not create user when password is blank") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password_confirmation: "password"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages.first).to eq("Password can't be blank")
    end

    # password confirmation must be required
    it("should not create user when password confirmation is blank") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages.first).to eq("Password confirmation can't be blank")
    end

    # should check for password and confirm password to be same
    it("should check for password and confirm password to be same") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "123444"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
    end

    # email must be unique
    it("should check for unique email") do
      user = User.create(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      user1 = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      expect(user1).not_to be_valid
      expect(user1.errors.full_messages.first).to eq("Email has already been taken")
    end
  
    # should check for password minimum length
    it("should check for password minimum length") do
      user = User.new(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "pass",
        password_confirmation: "pass"
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages.first).to eq("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should check if user input password match in database' do
      user = User.create(
        lastname: "patel",
        firstname: "neerav",
        email: "neerav@email.com",
        password: "password",
        password_confirmation: "password"
      )
      authenticate = User.authenticate_with_credentials(user.email, user.password)
      expect(authenticate).to eq(user)
      end
  end
end
