require 'optparse'

opt = OptionParser.new

option = []

# コマンドラインからのaの引数取得
opt.on('-a') do |val|
  option << 'a' unless val.nil?
end

# コマンドラインからのlの引数取得
opt.on('-l') do |val|
  option << 'l' unless val.nil?
end

# コマンドラインからのrの引数取得
opt.on('-r') do |val|
  option << 'r' unless val.nil?
end

opt.parse(ARGV)

def is_hidden_file(file)
  if (file == '.') || (file == '..') || file[0] == '.'
    true
  else
    false
  end
end

def show_file_details(_file)
  detailes = ''
  detailes += if File::Stat.new(_file).directory? == true
                'd'
              else
                '-'
              end

  detailes += switch_file_mode(File::Stat.new(_file).mode.to_s(8).slice(-3, 1))
  detailes += switch_file_mode(File::Stat.new(_file).mode.to_s(8).slice(-2, 1))
  detailes += switch_file_mode(File::Stat.new(_file).mode.to_s(8).slice(-1, 1))
end
result = ''
Dir.foreach(Dir.pwd) do |_item|
  next if !option.include?('a') && (is_hidden_file(_item) == true)

  _item = show_file_details(_item) + _item if option.include?('l')
  p _item
end
