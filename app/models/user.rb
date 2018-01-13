class User < ActiveRecord::Base
  # #2 register an inline callback directly after the before_save callback.  { self.email = email.downcase } is the code that will run when the callback executes
  before_save { self.email = email.downcase if email.present? }

  before_save :format_name

  # #3 use Ruby's validates function to ensure that name is present and has a maximum and minimum length
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  # #4 The first validation executes if password_digest is nil. This ensures that when we create a new user, they have a valid password. The second validation ensures that when updating a user's password, the updated password is also six characters long. allow_blank: true skips the validation if no updated password is given. This allows us to change other attributes on a user without being forced to set the password
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  # #5 validate that email is present, unique, case insensitive, has a minimum length, has a maximum length, and that it is a properly formatted email address
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 254 }
  # #6 use Ruby's has_secure_password. has_secure_password "adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a password_digest attribute". This function abstracts away much of the complexity of obfuscating user passwords using hashing algorithms which we would otherwise be inclined to write to securely save passwords. has_secure_password requires a  password_digest attribute on the model it is applied to. has_secure_password creates two virtual attributes, password and password_confirmation that we use to set and save the password
  has_secure_password

  def format_name
    if name
      name_array = []
      name.split.each do |name|
        name_array << name.capitalize
      end

      self.name = name_array.join(" ")
    end
  end
end
