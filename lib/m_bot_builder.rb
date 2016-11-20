require "m_bot_builder/version"
require "m_bot_builder/node_base"
require "m_bot_builder/bot_base"
require "m_bot_builder/serializer"
require "yaml"
require 'm_bot_builder/railtie' if defined?(Rails)

module MBotBuilder
	def self.init
		Dir["config/bots/*.yml"].each do |path|
			file_name = File.basename(path, ".yml")
			bot_conf = YAML::load_file(path)
			bot_klass = self.const_set file_name.capitalize!, Module.new
			bot_klass.extend(BotBase)
			cascade_modules(bot_conf,bot_klass,bot_klass)
		end
	end

	def self.cascade_modules(hash,base_klass,bot_klass)
		keys = hash.keys
		if keys[0] == "message"
			base_klass.const_set :Message, hash["message"]
			bot_klass.const_set :Starter, base_klass unless bot_klass.const_defined?("Starter")
			bot_klass
			return true 
		end
		keys.each do |key|
			klass = base_klass.const_set key.capitalize, Module.new
			klass.extend(NodeBase)
			cascade_modules(hash[key],klass,bot_klass)
		end
	end
end
