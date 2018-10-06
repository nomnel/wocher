require 'net/http'

class HatenaBookmark::Api
  Entry = Struct.new(:count, :url, keyword_init: true)

  def counts(urls)
    uri = URI.parse('http://api.b.st-hatena.com/entry.counts')
    uri.query = urls.map {|x| "url=#{CGI.escape(x)}" }.join('&')
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.host, uri.port) {|x| x.request(req) }
    return [] unless res.is_a?(Net::HTTPSuccess)

    json = JSON.parse(res.body)
    json.map {|url, count| Entry.new(url: url, count: count) }
  end
end
