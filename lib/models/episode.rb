require 'active_record'

class Episode < ActiveRecord::Base
  validates :season, :number, :title, :date, presence: true
end
