class Page < ApplicationRecord
  has_many :hatena_bookmark_snapshots,
    class_name: 'HatenaBookmark::Snapshot',
    dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  def self.pull!
    HatenaBlog::Client.new.entries.each do |entry|
      page = find_or_initialize_by(url: entry.url)
      page.title = entry.title
      break unless page.changed?
      page.save!
    end
  end

  def self.snapshot!
    today = Date.today
    find_in_batches(batch_size: 50) do |pages|
      url_page_map = {}.tap {|map|
        pages.each do |page|
          map[page.url] = page
        end
      }

      HatenaBookmark::Client.new.counts(url_page_map.keys).each do |x|
        snapshot = HatenaBookmark::Snapshot.find_or_initialize_by(
          date: today,
          page: url_page_map[x.url],
        )
        snapshot.count = x.count
        snapshot.save!
      end
    end
  end
end
