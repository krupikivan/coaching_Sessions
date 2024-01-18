class Client < ApplicationRecord
  self.table_name = 'clients'
  self.primary_key = 'client_hash_id'

  validates :client_hash_id, presence: true, uniqueness: true

  has_many :sessions, primary_key: 'client_hash_id', foreign_key: 'client_hash_id'
end
