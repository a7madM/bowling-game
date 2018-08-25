class BowlingScore
  attr_accessor :frames, :bonus

  def initialize(rolls)
    rolls = complete_rolls(rolls)
    to_frames(rolls)
    self.bonus = frames.last
  end

  def complete_rolls(rolls)
    if rolls.length < 22
      (22 - rolls.length).times do
        rolls.push(0)
      end
    end
    rolls
  end

  def to_frames(rolls)
    length = rolls.length - 2
    self.frames = []
    (0..length).step(2).each do |i|
      if rolls[i] == 10
        frames.push([rolls[i], 0])
      else
        frames.push([rolls[i], rolls[i + 1]])
      end
    end
  end

  def strike?(frame)
    frame.nil? ? false : frame[0] == 10
  end

  def spare?(frame)
    frame.nil? ? false : !strike?(frame) && sum_frame(frame) == 10
  end

  def score
    score = 0
    frames.each_with_index do |frame, index|
      score += sum_frame(frame) if !strike?(frame) && !spare?(frame) && frame.object_id != bonus.object_id
      score += score_spare(frame, index) if spare?(frame) && frame.object_id != bonus.object_id
      score += score_strike(frame, index) if strike?(frame) && frame.object_id != bonus.object_id
    end
    score += bonus[0] + bonus[1]
    score
  end

  private

  def sum_frame(frame)
    frame.nil? ? 0 : frame.inject(:+)
  end

  def score_strike(frame, index)
    if strike?(frames[index + 1]) && frames[index + 1].object_id != bonus.object_id
      frame[0] + frames[index + 1][0] + frames[index + 2][0]
    else
      frame[0] + sum_frame(frames[index + 1])
    end
  end

  def score_spare(frame, index)
    frames[index + 1] ? sum_frame(frame) + frames[index + 1][0] : sum_frame(frame)
  end
end
