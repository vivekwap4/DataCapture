class Project < ActiveRecord::Base
  belongs_to :researchers
  has_many :forms
end
