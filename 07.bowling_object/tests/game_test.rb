require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < MiniTest::Test
  def test_game
    assert_equal Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').points, 139
    assert_equal Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X').points, 164
    assert_equal Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4').points, 107
    assert_equal Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0').points, 134
    assert_equal Game.new('X,X,X,X,X,X,X,X,X,X,X,X').points, 300
  end
end
