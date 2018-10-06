class Page < ApplicationRecord
  has_many :hatena_bookmark_snapshots,
    class_name: 'HatenaBookmark::Snapshot',
    dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  def self.pull!
    HatenaBlog::Api.new.entries.each do |entry|
      page = find_or_initialize_by(url: entry.url)
      page.title = entry.title
      break unless page.changed?
      page.save!
    end
  end
end
