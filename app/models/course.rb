class Course < ApplicationRecord
    validates_presence_of :name, :release_date
end
