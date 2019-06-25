require './idea'

class IdeaBoxApp < Sinatra::Base
	set :method_override, true

	not_found do
		erb :error
	end

	configure :development do
		register Sinatra::Reloader
	end

	get '/' do
		erb :index, :locals => {:ideas => Idea.all}
	end

	get '/:id' do |id|
		erb :show, :locals => {:idea => Idea.find(id.to_i), :id => id}
	end

	get '/:id/edit' do |id|
		erb :edit, :locals => {:idea => Idea.find(id.to_i), :id => id}
	end

	put '/:id' do |id|
		idea = Idea.new(params[:idea_title], params[:idea_description])
		Idea.update(id.to_i, idea)
		redirect '/'
	end

	post '/' do
		idea = Idea.new(params['idea_title'], params['idea_description'])
		idea.save
		redirect '/'
	end

	delete '/:id' do |id|
		Idea.delete(id.to_i)
		redirect '/'
	end

end