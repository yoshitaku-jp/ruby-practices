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
  input = readlines
  str = input.join

  print(lines_count(str).to_s + ' ')
  print(word_size(str).to_s + ' ')
  print(word_bytesize(str).to_s + ' ')
end

main
