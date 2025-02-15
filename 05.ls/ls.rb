require 'optparse'
require 'etc'

### input 入力

opt = OptionParser.new

$option = []

# コマンドラインからのaの引数取得
opt.on('-a') do |_val|
  $option << 'a'
end

# コマンドラインからのlの引数取得
opt.on('-l') do |_val|
  $option << 'l'
end

# コマンドラインからのrの引数取得
opt.on('-r') do |_val|
  $option << 'r'
end

opt.parse(ARGV)

### process 加工

# 隠しファイルをスキップするかの関数
def hidden_file?(file)
  (file == '.') || (file == '..') || file[0] == '.'
end

# ファイルのパーミッションを取得する関数
def switch_file_mode(num)
  permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-w', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x' }
  permission[num]
end

# ファイルの詳細情報を取得する関数
def show_file_details(file)
  file = File::Stat.new(file)

  detailes = file.directory? ? 'd' : '-'

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
inputs = Dir.children(Dir.pwd)

# 整列
def sort_files(list)
  list.sort
end

# 反転
def reverse_files?(list)
  list.reverse
end

inputs = sort_files(inputs)
inputs = reverse_files?(inputs) if $option.include?('r')

result = []
inputs.each do |item|
  next if !$option.include?('a') && (hidden_file?(item) == true)

  result << if $option.include?('l')
              show_file_details(item) + item
            else
              item
            end
end

### output 表示

# 行数を決める
def set_row_num(list)
  max_vertical = list.count / 3
end

# lオプション以外
def display_vertical(list)
  max_row = set_row_num(list)
  list = list.each_slice(max_row).to_a

  max_length = list.flatten.max_by(&:length)

  i = 0
  j = 0
  while j < max_row
    if i < 3
      print list[i][j].ljust(max_length.length) + ' '
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
