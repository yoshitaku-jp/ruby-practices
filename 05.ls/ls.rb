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

# 隠しファイルをスキップするかの関数
def hidden_file?(file)
  if (file == '.') || (file == '..') || file[0] == '.'
    true
  else
    false
  end
end

# ファイルのパーミッションを取得する関数
def switch_file_mode(_num)
  permission = { '7': 'rwx', '6': 'rw-', '5': 'r-w', '4': 'r--', '3': '-wx', '2': '-w-', '1': '--x' }
  permission[_num].to_s
end

# ファイルの詳細情報を取得する関数
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

# 表示列を3に固定したときに、何行目まで出力するかを決める関数
max_vertical = 0
max_vertical = if !option.include?('a')
                 Dir.glob(Dir.pwd + '/*').count / 3
               else
                 Dir.glob(Dir.pwd + '/*', File::FNM_DOTMATCH).count / 3
               end

result = Array.new(max_vertical) { Array.new(3, 0) }

i = 0
j = 0

Dir.foreach(Dir.pwd) do |_item|
  next if !option.include?('a') && (is_hidden_file(_item) == true)

  if option.include?('l')
    _item = show_file_details(_item) + _item
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
