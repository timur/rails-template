class PersonSearch < ActiveRecord::Migration[8.0]
  def up
    execute("CREATE VIRTUAL TABLE fts_people USING fts5(name, email, position, person_id)")
  end

  def down
    execute("DROP TABLE IF EXISTS fts_people")
  end
end
