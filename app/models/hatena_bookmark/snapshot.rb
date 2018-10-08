class HatenaBookmark::Snapshot < ApplicationRecord
  belongs_to :page

  validates :count,
    numericality: { greater_than_or_equal_to: 0, only_integer: true },
    presence: true
  validates :date, presence: true

  def self.most_increased(from_date:, limit: 3)
    date = maximum(:date)
    join_clause = sanitize_sql(
      ["left outer join #{table_name} as b on a.page_id = b.page_id and b.date = ?", from_date])
    select('a.*, (a.count - coalesce(b.count, 0)) as increased_count').
      from("#{table_name} as a").
      joins(join_clause).
      where('a.date = ?', date).
      order('increased_count desc').
      limit(limit)
  end
end
