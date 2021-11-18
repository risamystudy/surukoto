class Task < ApplicationRecord
  belongs_to :user
  
  has_many :bookmarks, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 100 } #100文字制限
end
