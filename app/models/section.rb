class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :classroom

  has_many :section_students, dependent: :destroy
  has_many :students, through: :section_students

  # regular: 50 minutes
  # extended: 80 minutes
  enum time_limit: [:regular, :extended]

  # everyday: everyday
  # mwf: Monday, Wednesday & Friday
  # tt: Tuesday, Thursday
  enum days: [:everyday, :mwf, :tt]

  delegate :full_name, to: :teacher, prefix: :teacher
  delegate :name, to: :classroom, prefix: :classroom

  scope :in_range, -> range {
    where(start_time: range)
  }

  def formatted_start_time
    start_time.strftime('%H:%M')
  end

  def formatted_end_time
    end_time.strftime('%H:%M')
  end

  def end_time
    start_time + (extended? ? 80.minutes : 50.minutes)
  end

  def days_group
    case days
    when 'mwf'
      'Monday, Wednesday, Friday'
    when 'tt'
      'Tuesday, Thursday'
    else
      'Everyday'
    end
  end
end
