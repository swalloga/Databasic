require 'active_support/inflector'
# TODO: add order, find by
class SQLObject
  def self.columns
    return @columns if @columns
    query = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    @columns = query.first.map { |e| e.to_sym }
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |e| self.new(e) }
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{self.table_name}.id = ?
    SQL

    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      if self.class.columns.include?(attr_name)
        send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||={}
  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(",")
    question_marks = []
    columns.length.times { question_marks << "?" }
    DBConnection.execute(<<-SQL, *self.attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks.join(',')})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    update_line = self.class.columns.map { |e| "#{e} = ?"}.join(',')
    DBConnection.execute(<<-SQL, *self.attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{update_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    id.nil? ? self.insert : self.update
  end
end
