require 'idea_box'

class IdeaBoxApp < Sinatra::Base
	set :method_override, true
	set :root, 'lib/app'

	not_found do
		erb :error
	end

	configure :development do
		register Sinatra::Reloader
	end

	get '/' do
		erb :index, :locals => {:ideas => IdeaStore.all.sort}
	end

	get '/:id' do |id|
		erb :show, :locals => {:idea => IdeaStore.find(id.to_i)}
	end

	get '/:id/edit' do |id|
		erb :edit, :locals => {:idea => IdeaStore.find(id.to_i)}
	end

	put '/:id' do |id|
		old_rank = IdeaStore.find(id.to_i).rank
		idea = Idea.new(params[:idea_title], params[:idea_description], old_rank, id)
		IdeaStore.update(id.to_i, idea)
		redirect '/'
	end

	post '/:id/like' do |id|
		idea = IdeaStore.find(id.to_i)
		idea.like!
		IdeaStore.update(id.to_i, idea)
		redirect '/'
	end

	post '/:id/dislike' do |id|
		idea = IdeaStore.find(id.to_i)
		idea.dislike!
		IdeaStore.update(id.to_i, idea)
		redirect '/'
	end

	post '/' do
		idea = Idea.new(params['idea_title'], params['idea_description'], 0, IdeaStore.all.size)
		IdeaStore.create(idea)
		redirect '/'
	end

	delete '/:id' do |id|
		IdeaStore.delete(id.to_i)
		redirect '/'
	end

end