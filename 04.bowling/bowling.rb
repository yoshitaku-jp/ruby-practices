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

# ポイント計算
point = 0
frames.each_with_index do |value, idx|
  point += if idx == 9 # 10フレーム目のみ
             value.sum
           elsif frames[idx][0] == 10 # ストライク
             if frames[idx + 1].length == 1 # 次もストライクなら
               10 + frames[idx + 1][0] + frames[idx + 2][0]
             else
               10 + frames[idx + 1][0] + frames[idx + 1][1] # 次がストライク以外
             end
           elsif frames[idx].sum == 10 # スペア

             frames[idx].sum + frames[idx + 1][0]
           else # スペアストライク以外
             value.sum
           end
end

p point
