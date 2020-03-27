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
end
