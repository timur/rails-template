module SqliteSearch
  extend ActiveSupport::Concern

  private def update_search_index
    primary_key = self.class.primary_key
    table_name = self.class.table_name
    foreign_key = self.class.to_s.foreign_key

    search_attrs = @@search_scope_attrs.each_with_object({}) { |attr, acc|
      acc[attr] = quote_string(send(attr) || "")
    }
    id_value = attributes[primary_key]

    sql_delete = <<~SQL.strip
      DELETE FROM fts_#{table_name} WHERE #{foreign_key} = #{id_value};
    SQL
    self.class.connection.execute(sql_delete)

    sql_insert = <<~SQL.strip
      INSERT INTO fts_#{table_name}(#{search_attrs.keys.join(", ")}, #{foreign_key})
      VALUES (#{search_attrs.values.map { |value| "'#{value}'" }.join(", ")}, #{attributes[primary_key]});
    SQL
    self.class.connection.execute(sql_insert)
  end

  private def delete_search_index
    primary_key = self.class.primary_key
    table_name = self.class.table_name
    foreign_key = self.class.to_s.foreign_key
    id_value = attributes[primary_key]

    sql_delete = <<~SQL.strip
      DELETE FROM fts_#{table_name} WHERE #{foreign_key} = #{id_value};
    SQL
    self.class.connection.execute(sql_delete)
  end

  def quote_string(s)
    s.gsub("\\", '\&\&').gsub("'", "''")
  end 

  included do
    after_save_commit :update_search_index
    after_destroy_commit :delete_search_index

    scope_foreign_key = to_s.foreign_key
    scope :full_search, ->(query) {
      return none if query.blank?

      sql = <<~SQL.strip
        SELECT #{scope_foreign_key} AS id FROM fts_#{table_name}
        WHERE fts_#{table_name} MATCH '#{query}' ORDER BY rank;
      SQL
      ids = connection.execute(sql).map(&:values).flatten
      where(id: ids)
    }
  end

  class_methods do
    def search_scope(*attrs)
      @@search_scope_attrs = attrs
    end

    def quote_string(s)
      s.gsub("\\", '\&\&').gsub("'", "''")
    end 

    def rebuild_search_index(*ids)
      target_ids = Array(ids)
      target_ids = self.ids if target_ids.empty?

      scope_foreign_key = to_s.foreign_key

      delete_where = Array(ids).any? ? "WHERE #{scope_foreign_key} IN (#{ids.join(", ")})" : ""
      sql_delete = <<~SQL.strip
        DELETE FROM fts_#{table_name} #{delete_where};
      SQL
      connection.execute(sql_delete)

      target_ids.each do |id|
        record = where(id: id).pluck(*@@search_scope_attrs, :id).first
        if record.present?
          id = record.pop

          sql_insert = <<~SQL.strip
            INSERT INTO fts_#{table_name}(#{@@search_scope_attrs.join(", ")}, #{scope_foreign_key})
            VALUES (#{record.map { |value| "'#{quote_string(value)}'" }.join(", ")}, #{id});
          SQL
          connection.execute(sql_insert)
        end
      end
    end
  end
end