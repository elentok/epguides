require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "EpGuides_search" do
  it "should return a single item when searching for 'Hawaii Five-O'" do
    results = EpGuides::search('Hawaii Five-O')
    results.length.should be 1
    results[0].title.should == 'Hawaii Five-O (1968)'
    results[0].url.should == 'http://epguides.com/HawaiiFiveO/'
  end

  it "should return a single item when searching for 'Hawaii Five-0'" do
    results = EpGuides::search('Hawaii Five-0')
    results.length.should be 1
    results[0].title.should == 'Hawaii Five-0 (2010)'
    results[0].url.should == 'http://epguides.com/HawaiiFiveO_2010/'
  end
end
