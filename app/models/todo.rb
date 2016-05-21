class Todo < ActiveRecord::Base
  validates :name, presence: true

  ##
  # Determines if the Todo has been completed
  # @return [Boolean] the completion status of the todo item
  def completed?
    completed
  end
end
