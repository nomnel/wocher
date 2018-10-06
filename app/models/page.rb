class Page < ApplicationRecord
  has_many :hatena_bookmark_snapshots,
    class_name: 'HatenaBookmark::Snapshot',
    dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
end
