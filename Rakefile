# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

task :package do |t|
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "epguides"
    gem.homepage = "http://github.com/elentok/epguides"
    gem.license = "MIT"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "3david@gmail.com"
    gem.authors = ["David E"]
    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new
end

task :spec do |t|
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end
end

task :rcov do |t|
  RSpec::Core::RakeTask.new(:rcov) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov = true
  end
end

task :rdoc do |t|
  require 'rdoc/task'
  RDoc::Task.new do |rdoc|
    version = File.exist?('VERSION') ? File.read('VERSION') : ""

    rdoc.rdoc_dir = 'rdoc'
    rdoc.title = "epguides #{version}"
    rdoc.rdoc_files.include('README*')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
end

task :migrate do |t|
  migrations = []
  dir = Dir.new('lib/db')
  dir.each do |filename|
    migrations << filename if /^migration/ =~ filename
  end
  migrations.sort
  migrations.each do |filename|
    fullpath = "lib/db/#{filename}"
    require_relative fullpath
    puts "RUNNING MIGRATION #{filename}"
    class_name = filename.sub(/^m/, 'M').sub(/.rb/, '')
    puts class_name
    migration = (eval class_name)
    puts migration
  end
end
