class User < ActiveRecord::Base
  
  has_secure_password

  validates :firstname, :lastname, :email, :password, :password_confirmation, presence: true
  validates_uniqueness_of :email, case_sensitive: false
  validates :password, length: { minimum: 6 }
  
  def self.authenticate_with_credentials(email, password)
    trimmed_email = email.strip
    downcase_email = trimmed_email.downcase
    
    user = User.find_by(email: downcase_email)
    user && user.authenticate(password)
  end

end
