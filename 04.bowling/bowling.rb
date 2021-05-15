score = ARGV[0]

scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X' # ストライク
    shots << 10
    shots << 0
  elsif s == 'S' # スペア
    shots << 10
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each do |frame|
  point += if frame[0] == 10
             30
           elsif frame.sum == 10
             frame[0] + 10
           else
             frame.sum
           end
end

p point
