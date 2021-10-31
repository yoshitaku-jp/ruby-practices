require 'minitest/autorun'
require_relative '../lib/dir_info'

class DirInfoTest < MiniTest::Test
  def test_initialize()
    dir_info = DirInfo.new()
    assert_kind_of Array, dir_info.files
  end

  def test_sort_files()
    dir_info = DirInfo.new()
    assert_equal [1,2,3], dir_info.sort_files([3,2,1])
  end

  def test_reverse_files()
    dir_info = DirInfo.new()
    assert_equal [3,2,1], dir_info.reverse_files([1,2,3])
  end
end
