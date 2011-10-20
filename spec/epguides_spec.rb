require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "EpGuides_search" do
  it "should return a single item when searching for 'Hawaii Five-O'" do
    results = EpGuides::search('Hawaii Five-O')
    results.length.should be 1
    results[0].title.should == 'Hawaii Five-O (1968)'
    results[0].url.should == 'http://epguides.com/HawaiiFiveO/'
    results[0].epguides_id.should == 'HawaiiFiveO'
  end

  it "should return a single item when searching for 'Hawaii Five-0'" do
    results = EpGuides::search('Hawaii Five-0')
    results.length.should be 1
    results[0].title.should == 'Hawaii Five-0 (2010)'
    results[0].url.should == 'http://epguides.com/HawaiiFiveO_2010/'
    results[0].epguides_id.should == 'HawaiiFiveO_2010'
  end
end

describe "EpGuides::find_epguides_id" do
  it "should return 'HawaiiFiveO' for 'http://epguides.com/HawaiiFiveO'" do
    id = EpGuides::find_epguides_id('http://epguides.com/HawaiiFiveO')
    id.should == 'HawaiiFiveO'
  end
end

describe "EpGuides::find_epguides_id" do
  it "should return 'HawaiiFiveO' for 'http://epguides.com/HawaiiFiveO/'" do
    id = EpGuides::find_epguides_id('http://epguides.com/HawaiiFiveO/')
    id.should == 'HawaiiFiveO'
  end
end

describe 'EpGuides::get_episodes()' do

  it "should return episodes" do
    EpGuides.class_eval do
      def self.download(url)
        open('spec/BurnNotice.html')
      end
    end
    episodes = EpGuides::get_episodes("BurnNotice")
    episodes.length.should be 80
  end

  it "should return episode #1 = '1x1 - Pilot'" do
    EpGuides.class_eval do
      def self.download(url)
        open('spec/BurnNotice.html')
      end
    end
    episodes = EpGuides::get_episodes("BurnNotice")
    episodes.first.season.should be 1
    episodes.first.number.should be 1
    episodes.first.title.should == 'Pilot'
  end

end
