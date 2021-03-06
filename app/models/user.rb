class User < ActiveRecord::Base
  has_many :family_cards

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :name

  ROLES = %w[admin]

  # roles are stored in a single column using a bitmask as described here:
  # https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def username
    "#{name} <#{email}>"
  end
  alias_method :to_s, :username
end
