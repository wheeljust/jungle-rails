class User < ActiveRecord::Base

  has_secure_password
  before_validation :all_lowercase
  validates :first_name, :last_name, :email, :password_digest, presence: true
  validates :email, uniqueness: true, case_sensitive: false
  validates :password, length: { minimum: 8 }


  def authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.downcase.strip)
    
    if @user && @user.authenticate(password)
      return @user
    end

    nil
  end


  private

  def all_lowercase
    self.email = email.downcase if email.present?
  end
  
end
