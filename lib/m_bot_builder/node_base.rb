module NodeBase
	def execute!(data={})
		p "executing"
		@data    = data
		@messenger_data = prepare_template
		persist!
		@messenger_data
	end

	private
		def prepare_template
			p "Payload"
			message = Object.const_get("#{self}::Message")
			p Serializer.extract(message)
		end
			
		def	persist!
			p "Presist"
		end
end