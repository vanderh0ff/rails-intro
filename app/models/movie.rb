class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  ALLRATINGS = ['G', 'PG', 'PG-13', 'R']
end

