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

result = ''
Dir.foreach(Dir.pwd) do |_item|
  next if !option.include?('a') && (is_hidden_file(_item) == true)

  p _item
end
