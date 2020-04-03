require 'sinatra'
require 'movie'
require 'yaml/store'

get ('/movies') do
	@movies = []
	@movies[0] = Movie.new
	@movies[0].title = "Herro"
	@movies[1] = Movie.new
	@movies[1].title = "Alien"
	@movies[2] = Movie.new
	@movies[2].title = "Terminator"
	erb :index
end

get ('/movies/new') do
	erb :new
end

class MovieStore

	def initialize(file_name)
	@store = YAML::Store.new(file_name)
	end

	def save(movie)
		@store.transaction do
		unless movie.id
			highest_id = @store.roots.max || 0
			movie.id = highest_id + 1
		end
		@store[movie.id] = movie
	end

end

end


post ('/movies/create') do
	"Received: #{params.inspect}"
#	@movie = Movie.new
#	@movie.title = params['title']
#	@movie.director = params['director']
#	@movie.year = params['year']
#	store.save(@movie)
#	redirest '/movies/new'
end

