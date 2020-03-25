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
		self.connection.execute insert_query, name, breed, weight
		
	end

	def self.find(id)
		dog_hash = connection.execute("SELECT * FROM dogs WHERE dogs.id= ? ", id).first
		Dog.new(dog_hash)
	end

	def self.connection
		connection = SQLite3::Database.new 'db/development.sqlite3'
		connection.results_as_hash = true
		connection
	end

	def connection
		self.class.connection
		
	end

end