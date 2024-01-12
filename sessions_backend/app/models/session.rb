class Session < ApplicationRecord
    self.table_name = 'sessions'

    belongs_to :client, primary_key: "client_hash_id", foreign_key: "client_hash_id"
    belongs_to :coach, primary_key: "coach_hash_id", foreign_key: "coach_hash_id"


    def response
        {
            "coach_hash_id": self.coach.coach_hash_id,
            "client_hash_id": self.client.client_hash_id,
            "start": self.start,
            "duration": self.duration,
        }
    end
end