class Profile < ApplicationRecord
  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  belongs_to :user

  include ImageUploader[:image]
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :title, presence: true
  validates :about, presence: true

  def existing_chats_profiles
    existing_chat_profiles = []
    self.chats.each do |chat|
      existing_chat_profiles.concat(chat.subscriptions.where.not(profile_id: self.id).map {|subscription| subscription.profile})
    end
    existing_chat_profiles.uniq
  end

  def full_name
    first_name + " "+ last_name
  end
end
