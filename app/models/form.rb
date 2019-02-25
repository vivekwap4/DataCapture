class Form < ActiveRecord::Base
  belongs_to :projects
  has_many :formattributes
  has_many :dataentries, through: :formsaccesses
end
