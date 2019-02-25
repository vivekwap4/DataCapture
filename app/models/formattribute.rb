class Formattribute < ActiveRecord::Base
  belongs_to :forms
  has_many :results
  has_many :resultsstagings
end
