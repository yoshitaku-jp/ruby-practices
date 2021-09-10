require 'minitest/autorun'
require './lib/shot'

class ShotTest < MiniTest::Test
  def test_shot
    assert Shot.new(1)
  end

  def test_score
    shot = Shot.new(1)
    assert_equal shot.score, 1
  end
end
