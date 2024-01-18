class ChangePrimaryKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :clients, :id
    remove_column :coaches, :id
    execute 'ALTER TABLE clients ADD PRIMARY KEY (client_hash_id);'
    execute 'ALTER TABLE coaches ADD PRIMARY KEY (coach_hash_id);'
  end
end
