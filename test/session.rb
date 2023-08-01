require 'minitest/autorun'
require_relative '../session.rb'

class SessionTest < Minitest::Test
  def test_generating_session_object
    session = Session.new("jana", "add_food")
    assert_equal session.next_action, :introduction
    assert_equal "jana", session.user
  end
  
  def test_introduction
    session = Session.new("jana", "add_food")
    assert_equal session.introduction, "Welcome to the food bot, what menu do you want to add?"
    assert_equal :save_food, session.next_action
  end
end