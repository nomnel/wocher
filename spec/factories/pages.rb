FactoryBot.define do
  factory :page do
    sequence(:title) {|n|  "title_#{n}"}
    sequence(:url) {|n|  "https://example.com/pages/#{n}"}
  end
end
