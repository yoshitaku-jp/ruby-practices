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

result = ''
Dir.foreach(Dir.pwd) do |_item|
  unless option.include?('a')
    next if (_item == '.') || (_item == '..') # カレントディレクトリと親ディレクトリを飛ばす
    next if _item[0] == '.' # 隠しファイルを飛ばす
  end

  p _item
end
