require_relative '../lib/file_info'
require_relative '../lib/display'


class LS
    def initialize(option)

        # 隠しファイル判定
        if  ! option.include?('a')
            file_names = Dir.children(Dir.pwd)
            file_names.reject! { |file_name| file_name[0] == "."} 
        else
            file_names = Dir.entries(Dir.pwd)
        end

        # 昇順と降順を判定
        if ! option.include?('r')
            file_names.sort!
        else
            file_names.reverse!
        end

        # 詳細情報出力の判定
        if option.include?('l')
            file_names.map! do |file_name|
                file_info = FileInfo.new(file_name)
                file_info.show_file_details + file_name
            end
        end

        # 画面出力判定
        display = Display.new()
        if option.include?('l')
            display.horizontal(file_names)
        else
            display.vertical(file_names)
        end
    end
end
