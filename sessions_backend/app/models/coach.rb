class Coach < ApplicationRecord
  self.table_name = 'coaches'
  self.primary_key = 'coach_hash_id'

  validates :coach_hash_id, presence: true, uniqueness: true
  has_many :sessions, primary_key: 'coach_hash_id', foreign_key: 'coach_hash_id'

  def has_overlapping_session?(new_start, new_duration)
    # Get the end time of the new session
    new_end = new_start + new_duration

    # Checking every sessions from this coach
    sessions.any? do |session|
      existing_start = session.start # Start time
      existing_end = existing_start + session.duration # End time
      # Checking if the new session overlaps with the existing one
      (new_start < existing_end) && (new_end > existing_start)
    end
  end
end
