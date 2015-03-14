class User < ActiveRecord::Base
  has_secure_password

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :username, presence: true, uniqueness: true

  def set_default_role
    self.role ||= :user
  end

end
