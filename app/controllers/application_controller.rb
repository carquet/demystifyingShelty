class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token

	def home
		render 'application/home'
	end

	def list_dogs
		
		dogs = connection.execute "SELECT * FROM dogs;"
		
		render 'application/list_dogs', locals: {dogs: dogs}
	end

	def show_dog
		
		dog = find_by_id(params['id'])

		render 'application/show_dog', locals: {dog: dog}
		
	end

	def new_dog

		render 'application/create_dog'
	end

	def create_dog
		insert_query = <<-SQL
			INSERT INTO dogs (name, breed, weight)
			VALUES (?,?,?);
		SQL
		connection.execute insert_query,
			params['name'],
      params['breed'],
      params['weight']

		redirect_to '/list_dogs'	
	end

	def edit_dog
		dog = find_by_id(params['id'])
		render 'application/edit', locals: {dog: dog}
		
	end

	def update_dog
		update_query = <<-SQL
		UPDATE dogs
		SET name = ?,
		 		breed = ?,
				weight = ?
		WHERE dogs.id = ?
		SQL

		connection.execute update_query, params['name'], params['breed'], params['weight'], params['id']
		redirect_to '/list_dogs'
	end

	def connection
		connection = SQLite3::Database.new 'db/development.sqlite3'
		connection.results_as_hash = true
		connection
	end

def find_by_id(id)
	connection.execute("SELECT * FROM dogs WHERE dogs.id= ? ", params['id']).first
end
	
end
