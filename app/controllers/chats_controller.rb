require 'securerandom'
class ChatsController < ApplicationController

  def index
    # @profiles = Profile.all

    # @current_user_chats = current_user.profile.chats

    # other users's profiles' existing chat subscriptions other than for the current user profile
    @other_existing_chats_subscription_profiles = current_user.profile.existing_chats_profiles
  end

  def show
    @other_profile = Profile.find(params[:profile_id])
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @other_profile = Profile.find(params[:other_profile])
    @chat = find_chat(@other_profile) || Chat.new(identifier: SecureRandom.hex)
    if !@chat.persisted?
      @chat.save
      @chat.subscriptions.create(profile_id: @current_user.profile.id)
      @chat.subscriptions.create(profile_id: @other_profile.id)
    end
    redirect_to profile_chat_path(current_user.profile.id, @chat, :other_user => @other_profile.id)
  end

private
  def find_chat(second_profile)
    chats = current_user.profile.chats
    chats.each do |chat|
      chat.subscriptions.each do |s|
        if s.profile_id == second_profile.id
          return chat
        end
      end
    end
    nil
  end
end
