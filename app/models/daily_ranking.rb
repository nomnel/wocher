class DailyRanking
  def notify
    from_date = Date.today - 1.day
    snapshots = HatenaBookmark::Snapshot.
      most_increased(from_date: from_date, limit: 3).preload(:page).
      select {|x| x.increased_count > 0 }
    return if snapshots.empty?

    text = snapshots.map.with_index(1) {|snapshot, rank|
      page = snapshot.page
      ["第#{rank}位 (前日比: +#{snapshot.increased_count})", page.title, page.url].join("\n")
    }.join("\n\n")
    Slack::Client.new.post(text, icon_emoji: ':tada:', user_name: 'はてブ獲得ランキング(デイリー)')
  end
end
