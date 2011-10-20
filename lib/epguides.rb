require 'rubygems'
require 'googleajax'
require 'yaml'

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

end

class ShowResult
  attr_accessor :title, :url, :cache_url, :epguides_id
end

results = EpGuides::search('Hawaii Five-O')
