require_relative './message.rb'

class Session
  attr_reader :next_action, :user
  attr_accessor :command

  def initialize(user, command)
    @user = user
    @command = command
    @next_action = :introduction
    @message_history = []
  end

  def introduction
    @next_action = :save_food
    "Welcome to the food bot, what menu do you want to add?"
  end

  def save_food(message_body)

  end

  def add_to_history(message_body)
    @message_history << message_body
  end
end
