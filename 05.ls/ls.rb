require 'optparse'
require 'etc'

### input 入力
opt = OptionParser.new

$option = []

# コマンドラインからのaの引数取得
opt.on('-a') do |val|
  $option << 'a' unless val.nil?
end

# コマンドラインからのlの引数取得
opt.on('-l') do |val|
  $option << 'l' unless val.nil?
end

# コマンドラインからのrの引数取得
opt.on('-r') do |val|
  $option << 'r' unless val.nil?
end

opt.parse(ARGV)

### process 加工
# 隠しファイルをスキップするかの関数
def hidden_file?(file)
  (file == '.') || (file == '..') || file[0] == '.'
end

# ファイルのパーミッションを取得する関数
def switch_file_mode(_num)
  permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-w', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x' }
  permission[_num]
end

# ファイルの詳細情報を取得する関数
def show_file_details(_file)
  file = File::Stat.new(_file)

  detailes = ''
  detailes += if file.directory? == true
                'd'
              else
                '-'
              end

  [-3, -2, -1].each do |i|
    detailes += switch_file_mode(file.mode.to_s(8).slice(i, 1))
  end

  detailes += ' ' + file.nlink.to_s + ' '

  detailes += Etc.getpwuid(file.uid).name + ' '
  detailes += Etc.getgrgid(file.gid).name + ' '
  detailes += file.size.to_s + ' '
  detailes += file.mtime.to_s + ' '

  detailes
end

# データの加工処理
### output 表示

# 行数を決める
                   Dir.glob(Dir.pwd + '/*').count / 3
                 else
                   Dir.glob(Dir.pwd + '/*', File::FNM_DOTMATCH).count / 3
                 end
  result = Array.new(max_vertical) { Array.new(3, 0) }
else
  result = []
end

# lオプション以外
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
# lオプション
  end
end

# lオプションで表示方法を変える
else
  result.each do |data|
    print data.join('  ')
    puts ''
  end
end
