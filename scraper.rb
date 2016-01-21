# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new


['cfkargentina', 'anitamontanaro', 'casarosadaar', '678elprograma', 'mauriciomacri', 'CasaRosada', 'presidentpinedo', 'Kicillofok', 'gabimichetti', 'horaciorlarreta', 'SergioMassa', 'danielscioli', 'minsaurralde', 'FuiDespedidoAR'].each do |account|
  page = agent.get("https://twitter.com/#{account}")
  time = Time.now
  followers_link = page.links.detect {|link| link.text.include? 'Followers'}

  count = (followers_link.text.match /^\n\s*([^\n]+)/)[1]
  count_without_commas = count.gsub ',', ''

  ScraperWiki.save_sqlite(["account_time"], {"account_time" => "#{account}_#{time.strftime '%Y%m%d_%H%M%S'}", "account" => account, "followers" => count_without_commas, "followers_read" => count, "link_read" => followers_link.text, "time" => time})
end
