class Researcher < ActiveRecord::Base
  has_many :projects

  validates :authentications_id, :presence => true

  def self.create_researcher(attributes)
    Researcher.create(attributes)
  end

end
