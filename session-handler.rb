require_relative './session.rb'
require_relative './message.rb'

class SessionHandler
  def initialize
    @sessions = []
  end

  def session_of(message)
    user_session = @sessions.find { |session| session.user == message.user }
    user_session.add_to_history(message.body) if user_session
    user_session
  end

  def add_session(message)
    @sessions.delete_if { |session| session.user == message.user }
    user_session = Session.new(message.user, message.command)
    user_session.add_to_history(message.body)
    @sessions << user_session
    user_session
  end
end
