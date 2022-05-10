require './nameable'

class Decorator < nameable
  attr_accessor :nameable

  def initialize(nameable)
    @nameable = nameable
    super
  end

  def correct_name
    @nameable.correct_name
  end
end
