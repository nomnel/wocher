FactoryBot.define do
  factory :hatena_bookmark_snapshot, class: 'HatenaBookmark::Snapshot' do
    page
    count { 0 }
    date { Date.today }
  end
end
