class HatenaBookmark::Snapshot < ApplicationRecord
  belongs_to :page

  validates :count,
    numericality: { greater_than_or_equal_to: 0, only_integer: true },
    presence: true
  validates :date, presence: true
end
