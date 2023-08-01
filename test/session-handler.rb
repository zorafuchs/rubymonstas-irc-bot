require 'minitest/autorun'
require_relative '../session-handler.rb'

class SessionHandlerTest < Minitest::Test
  def test_session_of_with_empty_sessions
    message = Message.new(':nina!~nina@109.202.218.248 PRIVMSG #rubymonstas :blubb')
    session_handler = SessionHandler.new
    assert_nil session_handler.session_of(message)
    # assert_equal session_handler.session_of(message).user, "nina"
    # assert_equal session_handler.session_of(message).next_action, :introduction
  end

  def test_session_of_without_sessions_of_user
    message = Message.new(':nico!~nico@109.202.218.248 PRIVMSG #rubymonstas :blubb')
    session_handler = SessionHandler.new
    assert_nil session_handler.session_of(message)
    # assert_equal session_handler.session_of(message).user, "nico"
    # assert_equal session_handler.session_of(message).next_action, :introduction
  end

  def test_session_of_with_existing_session_of_user
    message = Message.new(':nina!~nina@109.202.218.248 PRIVMSG #rubymonstas :blubb')
    session_handler = SessionHandler.new
    session = session_handler.add_session(message)
    assert_equal session_handler.session_of(message), session
  end
end