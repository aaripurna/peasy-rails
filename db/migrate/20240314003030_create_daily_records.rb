class CreateDailyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_records do |t|
      t.date :date
      t.integer :male_count
      t.integer :female_count
      t.decimal :male_avg_age
      t.decimal :female_avg_age

      t.timestamps
    end
  end
end
