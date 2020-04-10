class Student
  attr_reader :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(name)
    grade > name.grade
  end

  protected

  attr_reader :grade
end