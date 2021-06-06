require 'optparse'
require 'etc'

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

# 隠しファイルをスキップするかの関数
def hidden_file?(file)
  true if (file == '.') || (file == '..') || file[0] == '.'
end

# ファイルのパーミッションを取得する関数
def switch_file_mode(_num)
  permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-w', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x' }
  permission[_num]
end

# ファイルの詳細情報を取得する関数
def show_file_details(_file)
  detailes = ''
  detailes += if File::Stat.new(_file).directory? == true
                'd'
              else
                '-'
              end

  [-3, -2, -1].each do |i|
    detailes += switch_file_mode(File::Stat.new(_file).mode.to_s(8).slice(i, 1))
  end

  detailes += ' ' + File::Stat.new(_file).nlink.to_s + ' '

  detailes += Etc.getpwuid(File::Stat.new(_file).uid).name + ' '
  detailes += Etc.getgrgid(File::Stat.new(_file).gid).name + ' '
  detailes += File::Stat.new(_file).size.to_s + ' '
  detailes += File::Stat.new(_file).mtime.to_s + ' '

  detailes
end

# オプションによって出力データの格納方式の変更
max_vertical = 0
result = ''
if !option.include?('l')
  max_vertical = if !option.include?('a')
                   Dir.glob(Dir.pwd + '/*').count / 3
                 else
                   Dir.glob(Dir.pwd + '/*', File::FNM_DOTMATCH).count / 3
                 end
  result = Array.new(max_vertical) { Array.new(3, 0) }
else
  result = []
end

# データ格納
i = 0
j = 0

Dir.foreach(Dir.pwd) do |_item|
  next if !option.include?('a') && (hidden_file?(_item) == true)

  if option.include?('l')
    result << show_file_details(_item) + _item
  elsif i < max_vertical
    result[i][j] = _item
    i += 1
  else
    i = 0
    j += 1
  end
end

result.each do |data|
  print data.join('  ')

  puts ''
end
