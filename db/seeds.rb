# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

puts "Deleting previous data"
Movie.destroy_all


puts "Generating new data..."

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=acde82cd5a12626eedefa47abb2cf386&language=en-US&page=3"
api_movies = URI.open(url).read
hash_movies = JSON.parse(api_movies)

array_movies = hash_movies["results"]
array_movies.each do |movie|
  title = movie["original_title"]
  overview = movie["overview"]
  poster_url = "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}"
  rating = movie["vote_average"]
  movie = Movie.create(title: title, overview: overview, poster_url: poster_url, rating: rating)
  p movie
end

puts "New data generated"
