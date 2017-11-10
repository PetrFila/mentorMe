class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_and_belongs_to_many :skills
  def init_profile
    self.create_profile!
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
