require './person'
# Teacher class
class Teacher
  def initialize(age, name, specialization)
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
