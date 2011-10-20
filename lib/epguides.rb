require 'rubygems'
require 'googleajax'
require 'yaml'
require 'open-uri'
require 'nokogiri'

GoogleAjax.referrer = 'elentok.com'

class EpGuides

  def self.search(title)
    results = GoogleAjax::Search.web('allintitle: site:epguides.com ' + title)
    shows = []
    results[:results].each do |result|
      show = ShowResult.new
      show.title = result[:title_no_formatting]
      show.title = show.title.sub(' (a Titles &amp; Air Dates Guide)', '')
      show.url = result[:unescaped_url]
      show.cache_url = result[:cache_url]
      show.epguides_id = EpGuides::find_epguides_id(show.url)
      shows.push(show)
    end
    return shows
  end

  def self.find_epguides_id(url)
    matches = /http:\/\/epguides.com\/([^\/]*)\/?$/.match(url)
    return nil if matches.nil?
    return matches[1]
  end

  def self.download(epguides_id)
    url = "http://epguides.com/#{epguides_id}"
    open(url)
  end

  def self.get_episodes(epguides_id)
    episodes = []

    doc = Nokogiri::HTML(download(epguides_id))
    anchors = doc.css('#eplist pre a')
    anchors.each do |a|
      title = a.attribute('title')
      next if title == nil
      matches = /season +([0-9]+) +episode +([0-9]+)/.match(title)
      next if matches == nil
      episode = Episode.new 
      episode.season = matches[1].to_i
      episode.number = matches[2].to_i
      episode.title = a.text
      date_matches = %r{[0-9]+/[A-Za-z]+/[0-9]+}.match(a.previous.text)
      episode.date = Date.parse(date_matches[0], comp=true)
      episodes.push(episode)
    end
    return episodes
  end


end

class ShowResult
  attr_accessor :title, :url, :cache_url, :epguides_id
end

class Episode
  attr_accessor :season, :number, :title, :date
end
