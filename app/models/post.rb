class Post < ApplicationRecord
  has_many :ranks, dependent: :destroy
  belongs_to :user
end
