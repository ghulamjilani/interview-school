class SectionStudent < ApplicationRecord
  belongs_to :section
  belongs_to :student

  delegate :teacher_full_name, to: :section
  delegate :classroom_name, to: :section
  delegate :days_group, to: :section, prefix: :section

  validate :section_overlap

  private

  def section_overlap
    matching_sections = student.sections
                               .where(days: section.days)
                               .where.not(id: section_id)

    matching_sections.each do |section|
      overlap_error and break if self.section.start_time.between?(section.start_time, section.end_time)
      overlap_error and break if self.section.end_time.between?(section.start_time, section.end_time)
    end
  end

  def overlap_error
    errors.add(:overlap_error, 'You can not enroll in overlapping sections')
  end
end
