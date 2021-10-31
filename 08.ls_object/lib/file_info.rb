class FileInfo
  attr_reader :file

  def initialize(file_name)
    @file = File::Stat.new(file_name)
  end
  
  # ファイルのパーミッションを取得する関数
  def switch_file_mode(num)
    permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-w', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x' }
    permission[num]
  end

  # 隠しファイルをスキップするかの関数
  def hidden_file?(file)
    (file == '.') || (file == '..') || file[0] == '.'
  end

  def show_file_details(file)
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

end
