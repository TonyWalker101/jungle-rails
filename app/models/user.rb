class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }

  def self.authenticate_with_credentials(email, password)

    email_trimmed = email.strip

    user = User.ci_find("email", email_trimmed)

    if user && user.authenticate(password) 
      user
    else
      nil
    end
    
  end
  
end
