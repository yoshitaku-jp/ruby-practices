class Display

  # lオプション
  def output_console_horizontal(file_names)
    file_names.each do |file_name|
      puts file_name
    end
  end

  # lオプション以外
  def output_console_vertical(file_names)
    max_row = set_row_num(file_names)
    file_names = file_names.each_slice(max_row).to_a

    file_name_max_length = file_names.flatten.max_by(&:length)

    i = 0
    j = 0
    while j < max_row
      if i < 3
        print "#{file_names[i][j].ljust(file_name_max_length.length)} "
        i += 1
      else
        puts ''
        j += 1
        i = 0
      end
    end
  end

  private
  # 行数を決める
  def set_row_num(file_names)
    max_row = file_names.count / 3
  end

end
