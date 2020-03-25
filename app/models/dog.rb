class  Dog
	attr_reader :id, :name, :breed, :weight

	def initialize(attributes={})
		set_attributes(attributes)
		@errors = {}
	end

	def set_attributes(attributes)
		@id = attributes['id'] if new_record?
		@name = attributes['name']
		@breed = attributes['breed']
		@weight = attributes['weight']
	end

	#1. blank is a Rails method

	def valid?
		@errors['name']  = "can't be blank" if name.blank?
    @errors['breed']   = "can't be blank" if breed.blank?
    @errors['weight'] = "can't be blank" if weight.blank?
    @errors.empty? #-->true
  end

# First, we change Model#save to react conditionally, 
# based on whether or not it's a new_record?. If it is, it calls insert, if not, update.
#change #insert and #update
	def new_record?
		id.nil?
	end

	def save
		#2. guard clause:
		#it prevents the information to be saved on the DB if not valid
		# the information will not be saved and return false
		# what next when returns false? -->> inform the user by showing diff views and messages according to situation
		return false unless valid?

		if new_record?
			insert
		else
			update
		end
		true
	end

	def insert
		insert_query = <<-SQL
			INSERT INTO dogs (name, breed, weight)
			VALUES (?,?,?)
		SQL
		connection.execute insert_query, name, breed, weight
		
	end

	def self.all
		hashes = connection.execute "SELECT * FROM dogs;"
		hashes.map do |hash|
			Dog.new(hash)
		end
		
	end

	def update
		update_query = <<-SQL
		UPDATE dogs
		SET name = ?,
		 		breed = ?,
				weight = ?
		WHERE dogs.id = ?
		SQL

		connection.execute update_query, name, breed, weight, id
		
	end

	def destroy
		connection.execute('DELETE FROM dogs WHERE dogs.id = ?', id)
		
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

