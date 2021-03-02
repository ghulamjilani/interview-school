module SectionsHelper
  def time_slot(section)
    "#{section.formatted_start_time} - #{section.formatted_end_time}"
  end
end
