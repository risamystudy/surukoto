class Task < ApplicationRecord
  belongs_to :user
  
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  
  validates :content, presence: true, length: { maximum: 100 } #100ζε­εΆι
end
