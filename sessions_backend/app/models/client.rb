class Client < ApplicationRecord
    self.table_name = 'clients'

    validates :client_hash_id, presence: true, uniqueness: true

    scope :find_by_hash, -> (hash) { where("client_hash_id = ?", hash) }
    
    has_many :sessions, primary_key: "client_hash_id", foreign_key: "client_hash_id"


    def response
        {
            "id": self.id,
            "name": self.name,
            "client_hash_id": self.client_hash_id,
        }
    end

end