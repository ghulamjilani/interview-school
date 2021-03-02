class Student < ApplicationRecord
  has_many :section_students, dependent: :destroy
  has_many :sections, through: :section_students
  has_many :classrooms, through: :sections
end
