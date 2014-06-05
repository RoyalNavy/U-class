class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  before_create {create_remember_token(:remember_token)}
  
  validates :name, presence: true, length: { maximum: 50 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #validates :password, length: { minimum: 6 }
  
  # remember the user from page to page by creating a remember_token and assign to
  # each user
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  

  def self.search(query)
# where(:title, query) -> This would return an exact match of the query
    where("users like ?", "%#{query}%") 
end
  
  def send_password_reset
    create_remember_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end
  

  private

  def create_remember_token(column)
      self[column]= User.digest(User.new_remember_token)
    end
  
  
end
