require 'sinatra'

require 'yaml/store'

class Movie
	attr_accessor :title, :director, :year, :id
end

class MovieStore

	def initialize(file_name)
		@store = YAML::Store.new(file_name)
	end
	def rf
		@store.transaction do
		@store.roots.map {|id| @store[id]}
		end
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
	def find(id)
		@store.transaction do
			@store[id]
		end

	end

end

store = MovieStore.new('movies1.yaml')


get('/movies') do 
	# @movie = []
	# @movie[0] = Movie.new
	# @movie[0].title = "Terminator"
	# @movie[0].director = "DFuko Trew"
	# @movie[0].year = "1999"
	# @movie[1] = Movie.new
	# @movie[1].title = "Matrica"
	# @movie[1].director = "Fanchkov"
	# @movie[1].year = "2001"
	# @movie[2] = Movie.new
	# @movie[2].title = "Alien"
	# @movie[2].director = "Monica"
	# @movie[2].year = "1979"
	@movie = store.rf
	erb :index1
end

get('/movies/new') do
	erb :new1
end




post('/movies/create') do
	#"Received: #{params.inspect}"
	@movie = Movie.new
	@movie.title = params['title']
	@movie.director = params['director']
	@movie.year = params['year']

	store.save(@movie)
	redirect '/movies'
end

get('/movies/:id') do
	id = params['id'].to_i
	@movie = store.find(id)
	erb :show
end