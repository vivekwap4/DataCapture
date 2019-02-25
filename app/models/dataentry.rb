class Dataentry < ActiveRecord::Base

  has_many :forms, through: :formsaccesses

  validates :authentications_id, :presence => true

  def self.create_dataentry(attributes)
    Dataentry.create(attributes)
  end

end
