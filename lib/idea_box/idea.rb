class Idea
	include Comparable
	attr_reader :title, :description, :rank, :id

	def initialize(title, description, rank, id)
		@title = title
		@description = description
		@rank = rank || 0
		@id = id
	end

	def like!
		@rank += 1
	end

	def dislike!
		@rank -= 1
	end

	def <=>(other)
		other.rank <=> @rank
	end
end
