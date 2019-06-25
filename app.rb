require './idea'
require './idea_store'

class IdeaBoxApp < Sinatra::Base
	set :method_override, true

	not_found do
		erb :error
	end

	configure :development do
		register Sinatra::Reloader
	end

	get '/' do
		erb :index, :locals => {:ideas => IdeaStore.all}
	end

	get '/:id' do |id|
		erb :show, :locals => {:idea => IdeaStore.find(id.to_i), :id => id}
	end

	get '/:id/edit' do |id|
		erb :edit, :locals => {:idea => IdeaStore.find(id.to_i), :id => id}
	end

	put '/:id' do |id|
		idea = Idea.new(params[:idea_title], params[:idea_description])
		IdeaStore.update(id.to_i, idea)
		redirect '/'
	end

	post '/' do
		idea = Idea.new(params['idea_title'], params['idea_description'])
		IdeaStore.create(idea)
		redirect '/'
	end

	delete '/:id' do |id|
		IdeaStore.delete(id.to_i)
		redirect '/'
	end

end