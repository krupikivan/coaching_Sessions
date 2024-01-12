require 'securerandom'

class CreateTablesForSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :client_hash_id, null: false
      t.timestamps
    end
    add_index :clients, :client_hash_id, unique: true


    create_table :coaches do |t|
      t.string :name, null: false
      t.string :coach_hash_id, null: false
      t.timestamps
    end
    add_index :coaches, :coach_hash_id, unique: true
  
    
    ['robert', 'james', 'john', 'michael', 'william', 'david', 'richard', 'charles', 'joseph', 'thomas'].each do |name|
      coach = Coach.new
      coach.name = name
      coach.coach_hash_id = coach_generate_unique_hash
      coach.save
    end
    ['mary', 'patricia', 'jennifer', 'linda', 'elizabeth', 'barbara', 'susan', 'jessica', 'sarah', 'karen'].each do |name|
      client = Client.new
      client.name = name
      client.client_hash_id = client_generate_unique_hash
      client.save
    end

    create_table :sessions do |t|
      t.timestamp :start, null: false
      t.integer :duration, null: false
      
      t.string :coach_hash_id, null: false
      t.string :client_hash_id, null: false

      t.timestamps
    end
    add_foreign_key :sessions, :coaches, column: :coach_hash_id, primary_key: "coach_hash_id"
    add_foreign_key :sessions, :clients, column: :client_hash_id, primary_key: "client_hash_id"
  end

  private
  def client_generate_unique_hash
    loop do
      random_hash = SecureRandom.base58(12)
      break random_hash unless Client.exists?(client_hash_id: random_hash)
    end
  end
  def coach_generate_unique_hash
    loop do
      random_hash = SecureRandom.base58(12)
      break random_hash unless Coach.exists?(coach_hash_id: random_hash)
    end
  end
end

