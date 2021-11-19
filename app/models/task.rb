class Task < ApplicationRecord
  belongs_to :user
  
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  
  validates :content, presence: true, length: { maximum: 100 } #100文字制限
end
