class FileInfo
  attr_reader :file

  def initialize(file_name)
    @file = File::Stat.new(file_name)
  end

  def show_file_details
    detailes = is_directory?

    [-3, -2, -1].each do |i|
      detailes += switch_file_mode(file.mode.to_s(8).slice(i, 1))
    end

    detailes += " #{file.nlink} "

    detailes += "#{Etc.getpwuid(file.uid).name} "
    detailes += "#{Etc.getgrgid(file.gid).name} "
    detailes += "#{file.size} "
    detailes += "#{file.mtime} "

    detailes
  end

  private

  def is_directory?
    file.directory? ? 'd' : '-'
  end

  # ファイルのパーミッションを取得する関数
  def switch_file_mode(num)
    permission = { '7' => 'rwx', '6' => 'rw-', '5' => 'r-w', '4' => 'r--', '3' => '-wx', '2' => '-w-', '1' => '--x' }
    permission[num]
  end
end
