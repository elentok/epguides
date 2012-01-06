require_relative 'db'

class Migration1 < ActiveRecord::Migration
  def self.up
    create_table :episodes do |t|
      t.string :title
      t.integer :season
      t.integer :number
      t.date :date
    end
  end

  def self.down
    drop_table :episodes
    
  end
end

Migration1.new.migrate :up
