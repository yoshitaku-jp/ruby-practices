score = ARGV[0]

scores = score.split(',')
shots = []

scores.each do |s|
  shots << if s == 'X' # ストライク
             10
  else
             s.to_i
  end
end

frames = []
max_frame = 10
roll = 1
tmp = []
shots.each_with_index do |_value, _idx|
  if frames.length + 1 < max_frame # 9投目まで
    if roll == 1
      tmp << _value
    elsif roll == 2
      tmp << _value
      frames << tmp
      tmp = []
    end

    if roll != 2
      roll += 1
    else
      roll = 1
    end
  else  # 10投目
    tmp << _value

    if tmp.sum < 10 && roll == 2 #2投以内にストライクとスペアがない
      frames << tmp
      break
    elsif roll == 3　#3頭目
      frames << tmp
      break
    end
    roll += 1
  end
end
p frames
