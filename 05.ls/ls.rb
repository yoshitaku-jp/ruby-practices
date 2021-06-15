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
def set_row_num
  max_vertical = if !$option.include?('a')
                   Dir.glob(Dir.pwd + '/*').count / 3
                 else
                   Dir.glob(Dir.pwd + '/*', File::FNM_DOTMATCH).count / 3
                 end
  result = Array.new(max_vertical) { Array.new(3, 0) }
else
  result = []
end

# lオプション以外
def display_vertical(_list)
  max_row = set_row_num
  _list = _list.each_slice(max_row).to_a

  i = 0
  j = 0
  while j < max_row
    if i < 3
      print _list[i][j] + ' '
      i += 1
    else
      puts ''
      j += 1
      i = 0
    end
  end
end

# lオプション
def display(list)
  list.each do |data|
    puts data
  end
end

# lオプションで表示方法を変える
if $option.include?('l')
  display(result)
else
  display_vertical(result)
end
