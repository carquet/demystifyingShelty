class Comment
	attr_reader	:id, :body, :potowner, :dog_id

	def initialize(attributes={})
		@id = attributes['id'] if new_record?
		@body = attributes['body']
		@potowner = attributes['potowner']
		@dog_id = attributes['dog_id']
		
	end

	def new_record?
		@id.nil?
		
	end

	def save
		if new_record?
			insert
		else
			return false
		end
	end

	def insert
		insert_comment_query = <<-SQL
      INSERT INTO comments (body, potowner, dog_id)
      VALUES (?, ?, ?)
    SQL

    connection.execute insert_comment_query,
      @body,
      @potowner,
      @dog_id
  	
		
	end

	def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end
