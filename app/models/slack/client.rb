require 'net/http'

class Slack::Client
  CHANNEL = ENV['SLACK_CHANNEL']
  INCOMING_WEBHOOK_URL = ENV['SLACK_INCOMING_WEBHOOK_URL']

  def post(text, icon_emoji: ':robot_face:', user_name: 'Wocher')
    uri = URI.parse(INCOMING_WEBHOOK_URL)
    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/json'
    req.body = JSON.generate(channel: CHANNEL, icon_emoji: icon_emoji, text: text, username: user_name)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') {|x| x.request(req) }
  end
end
