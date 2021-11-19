class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :tasks
#relationships関連
  has_many :relationships
  #中間テーブルを経由して向こう側のモデルのfollowカラムを参照,followings命名
  has_many :followings, through: :relationships, source: :follow
  #reverses_of_relationship命名、Relationship参照、user_idをfollow_id
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  #中間テーブルを経由して向こう側のモデルのuserカラムを参照,followers命名
  has_many :followers, through: :reverses_of_relationship, source: :user
  
#bookmarks関連
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_tasks, through: :bookmarks, source: :task
  
#フォロー関連
  def follow(other_user)
    unless self == other_user   #フォローするuserが自分自身ではないかどうか
      self.relationships.find_or_create_by(follow_id: other_user.id)  #重複しない。find→Rモデルのインスタンス、見つからなければcreate
    end
  end
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  #フォローしていないかどうか確認する
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_tasks
    Task.where(user_id: self.following_ids + [self.id])
  end
  
#ブックマーク関連 
  def bookmark(task)
    self.bookmarks.find_or_create_by(task_id: task.id)
  end
  def unbookmark(task)
    bookmark = self.bookmarks.find_by(task_id: task.id)
    bookmark.destroy if bookmark
  end
  def bookmark_task?(task)
    self.bookmark_tasks.include?(task)
  end
    
  

end
