require_relative './irc-connector.rb'
require_relative './stateless-reaction-controller.rb'
require_relative './session-handler.rb'
require_relative './session.rb'
require_relative './message.rb'

class MessageHandler
  def initialize
    @stateless_reaction_controller = StatelessReactionController.new
    @session_handler = SessionHandler.new
    @irc_connector = IRCConnector.new
    @irc_connector.connect
    @irc_connector.listen_for_messages(self.method(:receive))
  end

  def receive(message_string)
    message = Message.new(message_string)
    @session_handler.add_session(message) if message.command
    @session_handler.session_of(message) ? handle_stateful(message) : handle_stateless(message)
  end

  def handle_stateless(message)
    @irc_connector.send("PRIVMSG #rubymonstas :" + @stateless_reaction_controller.stateless_reaction_to(message)) if @stateless_reaction_controller.stateless_reaction_to(message) 
  end

  # :zora!~zora@178.197.219.229 PRIVMSG #rubymonstas :hello
  def handle_stateful(message)
    session = @session_handler.session_of(message)
    session.add_to_history(message)
    pp "todo: handle stateful message with #{session.command} in #{session}"
  end
end
