class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false
      t.references :classroom, null: false
      t.time :start_time
      t.integer :time_limit, default: 0
      t.integer :days, default: 0

      t.timestamps
    end
  end
end
