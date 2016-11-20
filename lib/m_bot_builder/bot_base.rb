module BotBase

	def start!(data={})
		Object.const_get("#{self}::Starter").execute!
	end

	def reply!(payload)
		klass = Object.const_get("MBotBuilder::#{payload}")
		data  = payload["data"]
		klass.execute!(data)
	end
end