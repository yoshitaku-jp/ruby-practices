class DirInfo
    attr_reader :files

    def initialize()
        @files = Dir.children(Dir.pwd)
    end

    # 整列
    def sort_files(files)
        files.sort
    end
  
    # 反転
    def reverse_files(files)
        files.reverse
    end
end
