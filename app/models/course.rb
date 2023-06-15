class Course < ApplicationRecord
  has_many :tutors

  validates :name, presence: true, uniqueness: true
end
