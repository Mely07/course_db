class Course < ApplicationRecord
    validates_presence_of :name, :release_date
    validates_format_of :release_date, :with => /\d{4}\/\d{2}\/\d{2}/, :message => "Must be in the following format: yyyy/mm/dd"

end
