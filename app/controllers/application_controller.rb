class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token

	def home
		render 'application/home'
	end

	def list_dogs
		
		dogs = Dog.all
		
		render 'application/list_dogs', locals: {dogs: dogs}
	end

	def show_dog
		
		dog = Dog.find(params['id'])

		render 'application/show_dog', locals: {dog: dog}
		
	end

	def new_dog
		render 'application/create_dog'
	end

	def create_dog
		dog = Dog.new('name' => params['name'],
									'breed' => params['breed'],
									'weight' => params['weight'])
		dog.save

		redirect_to '/list_dogs'	
	end

	def edit_dog
		dog = Dog.find(params['id'])
		render 'application/edit', locals: {dog: dog}
		
	end

	def update_dog
		dog = Dog.find(params['id'])
		dog.set_attributes('name' => params['name'], 'breed' => params['breed'], 'weight' => params['weight'])
		dog.save
		redirect_to '/list_dogs'
	end

	def delete_dog
		dog = Dog.find(params['id'])
		dog.destroy
		
		redirect_to '/list_dogs'
		
	end

	


	
end
