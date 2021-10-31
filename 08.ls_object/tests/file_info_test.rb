require 'minitest/autorun'
require_relative '../lib/file_info'

class FileInfoTest < MiniTest::Test

  def test_initialize()
    files = Dir.children(Dir.pwd)
    file_info = FileInfo.new(files[0])
    assert_kind_of File::Stat, file_info.file
  end

  def test_switch_file_mode
    files = Dir.children(Dir.pwd)
    file_info = FileInfo.new(files[0])
    assert_equal file_info.switch_file_mode('7'), 'rwx'
    assert_equal file_info.switch_file_mode('6'), 'rw-'
    assert_equal file_info.switch_file_mode('5'), 'r-w'
    assert_equal file_info.switch_file_mode('4'), 'r--'
    assert_equal file_info.switch_file_mode('3'), '-wx'
    assert_equal file_info.switch_file_mode('2'), '-w-'
    assert_equal file_info.switch_file_mode('1'), '--x'
  end

  def test_hidden_file?
    files = Dir.children(Dir.pwd)
    file_info = FileInfo.new(files[0])
    assert_equal file_info.hidden_file?('.'), true
    assert_equal file_info.hidden_file?('test'), false
  end

  def test_show_file_details
    files = Dir.children(Dir.pwd)
    file_info = FileInfo.new(files[0])
  end

end
