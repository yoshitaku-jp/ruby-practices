require_relative '../lib/dir_info'


class LS
    def initialize(option)
        file_names = Dir.children(Dir.pwd)

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

        p file_names

    end
end
