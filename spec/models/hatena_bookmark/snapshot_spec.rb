require 'rails_helper'

describe HatenaBookmark::Snapshot do
  describe '::most_increased' do
    let(:from_date) { today - 1.day }
    let(:page1) { FactoryBot.create(:page) }
    let(:page2) { FactoryBot.create(:page) }
    let(:today) { Date.today }
    let!(:snapshot_from_date_1) { FactoryBot.create(:hatena_bookmark_snapshot, page: page1, date: from_date, count: 1) }
    let!(:snapshot_today_1) { FactoryBot.create(:hatena_bookmark_snapshot, page: page1, date: today, count: 5) }
    let!(:snapshot_today_2) { FactoryBot.create(:hatena_bookmark_snapshot, page: page2, date: today, count: 5) }

    subject { HatenaBookmark::Snapshot.most_increased(from_date: Date.today - 1.day) }

    it do
      expect(subject).to eq [snapshot_today_2, snapshot_today_1]
    end
  end
end
