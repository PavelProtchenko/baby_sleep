class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ROLES = %w[admin].freeze

  serialize :roles, Array

  def add_role(role)
    new_roles = roles.push(role).uniq
    filtered_roles = new_roles.reject { |r| !ROLES.include?(r) }
    update(roles: filtered_roles)
  end

  def remove_role(role)
    filtered_roles = roles.reject { |r| r == role }
    update(roles: filtered_roles)
  end
end
