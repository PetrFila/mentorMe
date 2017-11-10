class Subscription < ApplicationRecord
  belongs_to :chat
  belongs_to :profile
end
