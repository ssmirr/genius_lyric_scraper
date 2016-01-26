require 'faraday'
require 'nokogiri'
require "pry"

url = ARGV[0]

def scrape(url)
	response = Faraday.get(url)
	doc = Nokogiri::HTML(response.body)
end

def get_album_links(url)
	doc = scrape(url)
	album_links = []
	doc.css('.album_link').each do |a|
		puts "fetching album: #{a[:href]}"
		album_links << a[:href]
	end
	album_links
end

def get_song_links(album_links)
	songs = []
	album_links.each do |link|
		doc = scrape('http://genius.com'+link)
		doc.css('.song_link').each do |a|
			puts "fetching song: #{a[:href]}"
			songs << a[:href]
		end
	end
	songs
end

albums = get_album_links(url)
songs = get_song_links(albums)