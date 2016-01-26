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

def scrape_lyrics(songs)
	songs.each.with_index(1) do |song, index|
		doc = scrape(song)
		song_name = "* * * " + doc.css('.song_header-primary_info-title').text.upcase + " * * *"
		lyrics = doc.css('.lyrics p').text.gsub(/\[.*\]/, "").gsub(/^$\n^$\n/, "\n").strip!
		File.open('lyrics.txt', 'a') do |f|
			f << song_name+"\n\n"+lyrics+"\n\n"
			puts "succesfully scraped song #{index.to_s} of #{songs.length.to_s}: #{song}"
		end
	end
end

albums = get_album_links(url)
songs = get_song_links(albums)
scrape_lyrics(songs)