class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false, primary_key: :uuid do |t|
      t.uuid :uuid, primary_key: true, default: 'gen_random_uuid()'
      t.string :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age

      t.timestamps
    end
  end
end
