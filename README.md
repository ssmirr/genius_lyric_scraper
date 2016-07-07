This is quick and dirty lyric scraper I threw together to fetch source material for my [Gucci Mane Lyric Generator](http://github.com/alexfulsome/guccimane_generator) because the public Genius API didn't offer what I needed. It will scrape an artist's entire body of work from [Genius](http://genius.com) and save it to an appropriately named text file. The applications for this are probably pretty limited but the normal warnings and caveats surrounding any web scraping still apply because Genius is cool: be responsible, don't slam them with a hundred thousand requests for the entire Cash Money catalog in an hour, web scraping is inherently brittle and this could break at any time, there might be the occasional weird formating issue, etc etc.

Dependencies:
**Faraday**,
**Nokogiri**, 
**Pry**

Usage:

```shell
ruby app.rb <ARTIST NAME>
```
