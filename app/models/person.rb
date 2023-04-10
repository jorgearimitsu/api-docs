class Person < ApplicationRecord
  validates :first_name, :email, presence: true
end
