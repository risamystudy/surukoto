class Task < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 100 } #100文字制限
end
