class Tutor < ApplicationRecord
  belongs_to :course

  validates :first_name, :last_name, uniqueness: true, presence: true
end
