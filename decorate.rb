require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(nameable_obj)
    super()
    @nameable = nameable_obj
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    if @nameable.correct_name.length > 10
      @nameable.correct_name[0, 10]
    else
      @nameable.correct_name
    end
  end
end
