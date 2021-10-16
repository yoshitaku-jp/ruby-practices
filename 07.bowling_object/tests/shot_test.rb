require 'minitest/autorun'
require './lib/shot'

class ShotTest < MiniTest::Test
  def test_shot
    assert Shot.new(1)
  end

  def test_score
    shot_1 = Shot.new(1)
    assert_equal shot_1.score, 1
    shot_10 = Shot.new('X')
    assert_equal shot_10.score, 10
  end
end
