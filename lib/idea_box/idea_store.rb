require 'yaml/store'

class IdeaStore
	def self.database
		@database ||= YAML::Store.new "db/ideabox"
	end

	def self.create(idea)
		database.transaction do |db|
			db['ideas'] ||= []
			db['ideas'] << {title: idea.title, description: idea.description}
		end
	end

	def self.all
	  raw_ideas.map do |data|
	    Idea.new(data[:title], data[:description])
	  end
	end

	def self.raw_ideas
	  database.transaction do |db|
	    db['ideas'] || []
	  end
	end

	def self.find(id)
		database.transaction do |db|
			raw_idea = db['ideas'][id]
			Idea.new(raw_idea[:title], raw_idea[:description])
		end
	end

	def self.delete(id)
		database.transaction do |db|
			db['ideas'].delete_at(id)
		end
	end

	def self.update(id, new_idea)
		database.transaction do |db|
			db['ideas'][id] = {:title => new_idea.title, :description => new_idea.description}
		end
	end
end