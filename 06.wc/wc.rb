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

  if ARGV.empty? == true
    str = gets
  else
    input = readlines
    str = input.join
  end

  print ARGV
  print str

  print(lines_count(str).to_s + ' ')
  print(word_size(str).to_s + ' ')
  print(word_bytesize(str).to_s + ' ')
end

main
