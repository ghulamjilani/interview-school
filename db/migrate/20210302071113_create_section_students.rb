class CreateSectionStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :section_students do |t|
      t.references :student, null: false
      t.references :section, null: false
      t.timestamps
    end
  end
end
