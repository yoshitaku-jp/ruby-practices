class Display

    def initialize()

    end

    # 行数を決める
    def set_row_num(list)
        max_vertical = list.count / 3
    end

    # lオプション
    def horizontal(files)
        files.each do |file|
            puts file
        end
    end

    # lオプション以外
    def vertical(files)
        max_row = set_row_num(files)
        files = files.each_slice(max_row).to_a
    
        max_length = files.flatten.max_by(&:length)
    
        i = 0
        j = 0
        while j < max_row
        if i < 3
            print files[i][j].ljust(max_length.length) + ' '
            i += 1
        else
            puts ''
            j += 1
            i = 0
        end
        end
    end
end