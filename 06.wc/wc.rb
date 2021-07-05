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
def main
  params = ARGV.getopts('l')
  input = []

  if File.pipe?($stdin)
    input = readlines
    str = input.join
    print_wc(str, params)
  elsif !ARGV.empty?
  else
    str = gets
    print_wc(str, params)
  end
end

main
