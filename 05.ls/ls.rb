Dir.foreach(Dir.pwd) do |item|
    next if item == '.' or item == '..' # カレントディレクトリと親ディレクトリを除外
    next if item[0] == '.'　# 隠しファイルを除外
    puts item
  end