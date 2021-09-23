class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def sum_score
    [first_shot.score, second_shot.score, third_shot.score].sum
  end

  def strike?
    true if @second_shot.mark.nil?
  end

  def spare?
    true if sum_score == 10 && !second_shot.mark.nil?
  end
end
