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

def main
  params = ARGV.getopts('l')
  input = []

  if File.pipe?(STDIN) || !ARGV.empty?
    input = readlines
    str = input.join
  else
    str = gets
  end

  print(lines_count(str).to_s + ' ')
  if params['l'] == false
    print(word_size(str).to_s + ' ')
    print(word_bytesize(str).to_s + ' ')
  end
end

main
