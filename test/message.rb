require 'minitest/autorun'
require_relative '../message.rb'

class MessageTest < Minitest::Test
  def test_stateless_message_creation
    message = Message.new(':zora!~zora@178.197.219.229 PRIVMSG #rubymonstas :hello')
    assert_equal "zora", message.user
    assert_equal "hello", message.body
    assert_nil message.command
  end

  def test_stateful_message_creation
    message = Message.new(':zora!~zora@178.197.219.229 PRIVMSG #rubymonstas :add_food: Chilli con Carne')
    assert_equal 'zora', message.user
    assert_equal 'Chilli con Carne', message.body
    assert_equal 'add_food', message.command
  end
end
