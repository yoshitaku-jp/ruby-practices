require 'minitest/autorun'
require './lib/frame'

class FrameTest < MiniTest::Test
  def test_frame
    assert Frame.new(1, 9)
  end

  def test_score
    frame = Frame.new(1, 9)
    assert_equal frame.score, 10
    frame_4 = Frame.new(4, 0)
    assert_equal frame_4.score, 4
    frame_7 = Frame.new(0, 7)
    assert_equal frame_7.score, 7

    frame_3shot = Frame.new(1, 9, 9)
    assert_equal frame_3shot.score, 19
  end
end
