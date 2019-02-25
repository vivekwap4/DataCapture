class Formsaccess < ActiveRecord::Base
  belongs_to :forms
  belongs_to :dataentries
end
