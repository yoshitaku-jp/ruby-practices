require 'optparse'

def lines_count(str)
  str.lines.count
end

def word_size(str)
  ary = str.split(/\s+/)
  ary.size
end

def word_bytesize(str)
  str.bytesize
end

def print_wc(str, params)
  print("#{lines_count(str)} ")
  return if params['l'] == true

  print("#{word_size(str)} ")
  print("#{word_bytesize(str)} ")
end

def files_process(files, params)
  total_str = ''
  files.each do |file|
    f = File.open(file)
    str = f.read
    total_str << str
    print_wc(str, params)
    puts(" #{file}")
    f.close
  end
  total_str
end

def main
  params = ARGV.getopts('l')

  if File.pipe?($stdin)
    input = readlines
    str = input.join
    print_wc(str, params)
  elsif !ARGV.empty?
    files = ARGV
    total_str = files_process(files, params)
    if files.count != 1
      print_wc(total_str, params)
      print(' total')
    end
  else
    str = gets
    print_wc(str, params)
  end
end

main
