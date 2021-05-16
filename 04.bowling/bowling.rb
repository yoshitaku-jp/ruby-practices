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

# フレームごとの分割

frames = []
max_frame = 10
roll = 1
tmp = []
shots.each do |value|
  if frames.length + 1 < max_frame # 9フレームまで
    if roll == 1 && value == 10 # ストライク
      tmp << value
      frames << tmp
      roll = 1
      tmp = []

    elsif roll == 1 # 1投目
      tmp << value
      roll += 1

    elsif roll == 2 # 2投目
      tmp << value
      frames << tmp
      roll = 1
      tmp = []
    end

  else # 10フレーム
    tmp << value
    if tmp.sum < 10 && roll == 2 # 2投以内にストライクとスペアがない
      frames << tmp
    elsif roll == 3 # 3投目
      frames << tmp

    end
    roll += 1
  end
end
p frames
