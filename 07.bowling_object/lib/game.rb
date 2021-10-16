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
    shots = []

    scores.each do |mark|
      shots << mark
      if frames.length + 1 < 10
        if mark == 'X'
          frames << Frame.new(*shots)
          shots = []
        elsif shots.length == 2
          frames << Frame.new(*shots)
          shots = []
        end
      end
    end
    frames << Frame.new(*shots)
    frames
  end

  def calc_score(frames)
    frames.each_with_index.sum do |frame, idx|
      if idx == 9
        frame.sum_score
      elsif frame.strike? # ストライク
        if frames[idx + 1].strike? # 次もストライクか確認
          10 + frames[idx + 1].sum_score + frames[idx + 2].first_shot.score
        else
          10 + frames[idx + 1].first_shot.score + frames[idx + 1].second_shot.score
        end
      elsif frame.spare? # スペア
        frame.sum_score + frames[idx + 1].first_shot.score
      else
        frame.sum_score
      end
    end
  end
end
