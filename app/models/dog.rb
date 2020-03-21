class  Dog
	attr_reader :id, :name, :breed, :weight

	def initialize(attributes={})
		@id = attributes['id']
		@name = attributes['name']
		@breed = attributes['breed']
		@weight = attributes['weight']
	end

	def save
		insert_query = <<-SQL
			INSERT INTO dogs (name, breed, weight)
			VALUES (?,?,?)
		SQL
		connection.execute insert_query, name, breed, weight
		
	end

	def connection
		connection = SQLite3::Database.new 'db/development.sqlite3'
		connection.results_as_hash = true
		connection
	end

end