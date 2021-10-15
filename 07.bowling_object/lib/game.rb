require_relative './frame'

class Game

  attr_reader :points

  def initialize(score)
    scores = split_score(score)
    frames = split_frame(scores)
    @points = calc_score(frames)
    p @points
  end

  def split_score(score)
    score.split(',')
  end

  def split_frame(scores)
    frames = []
    first_mark = nil
    second_mark = nil
    third_mark = nil
    roll = 1

    scores.each do |mark|
      if frames.length + 1 < 10
        if roll == 1 && mark == 'X'
          first_mark = mark
          frames << Frame.new(first_mark)
          first_mark = nil
          roll = 1
        elsif roll == 1
          first_mark = mark
          roll += 1
        elsif roll == 2
          second_mark = mark
          frames << Frame.new(first_mark, second_mark)
          first_mark = nil
          second_mark = nil
          roll = 1
        end
      else
        case roll
        when 1
          first_mark = mark
        when 2
          second_mark = mark

          frames << Frame.new(first_mark, second_mark) if first_mark.to_i + second_mark.to_i < 10 && first_mark != 'X'
        when 3
          third_mark = mark
          frames << Frame.new(first_mark, second_mark, third_mark)
        end
        roll += 1
      end
    end
    frames
  end

  def calc_score(frames)
    point = 0

    frames.each_with_index do |_frame, idx|
      point += if idx == 9
                 frames[idx].sum_score
               elsif frames[idx].strike? # ストライク
                 if frames[idx + 1].strike? # 次もストライクか確認
                   10 + frames[idx + 1].sum_score + frames[idx + 2].first_shot.score
                 else
                   10 + frames[idx + 1].first_shot.score + frames[idx + 1].second_shot.score
                 end
               elsif frames[idx].spare? # スペア
                 frames[idx].sum_score + frames[idx + 1].first_shot.score
               else
                 frames[idx].sum_score
               end
    end
    point
  end
end
