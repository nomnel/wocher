require 'net/http'

class HatenaBlog::Api
  API_KEY   = ENV['HATENA_BLOG_API_KEY']
  BLOG_NAME = ENV['HATENA_BLOG_BLOG_NAME']
  USER_NAME = ENV['HATENA_BLOG_USER_NAME']

  Entry = Struct.new(:title, :url, keyword_init: true)

  def entries
    Enumerator.new {|y|
      uri = URI.parse("https://blog.hatena.ne.jp/#{USER_NAME}/#{BLOG_NAME}/atom/entry")
      loop {
        break unless uri
        xs, uri = fetch_entries(uri)
        xs.each do |x|
          y << x
        end
      }
    }
  end

  private

  def fetch_entries(uri)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth(USER_NAME, API_KEY)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) {|x| x.request(req) }
    return [[], nil] unless res.is_a?(Net::HTTPSuccess)

    doc = Nokogiri::XML(res.body)
    next_uri = URI.parse(doc.css('link[rel=next]').first[:href]) rescue nil
    entries = doc.css('entry').map {|x|
      Entry.new(
        title: x.css('title').text,
        url: x.css('link[rel=alternate]').first[:href],
      )
    }
    [entries, next_uri]
  end
end
