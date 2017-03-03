require 'open-uri'
require 'Net/HTTP'
require 'JSON'
require 'pry'

uri = URI("https://api.nytimes.com/svc/search/v2/articlesearch.json")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

puts "Which day would you like headlines for?  Enter in YYYYMMDD format or leave blank for today."
input_date = gets.chomp
input_date = DateTime.now.strftime("%Y%m%d") if input_date == ""

uri.query = URI.encode_www_form({
  "api-key" => "68f00f41fbff4bbca99eff2673a153bd",
  "begin_date" => input_date,
  "end_date" => input_date,
  "sort" => "newest"
})
request = Net::HTTP::Get.new(uri.request_uri)
result = JSON.parse(http.request(request).body)

# ARTICLES: ["response"]["docs"]
# USE: ["headline"]["main"] && ["lead_paragraph"]

result["response"]["docs"].map  do |article|
  begin
    puts "\e[35m\e[4m#{article["headline"]["main"]}\e[0m\n"
    puts "#{article["byline"]["original"]}"
    if article["lead_paragraph"].length > 120
      puts article["lead_paragraph"][0..117].strip+"..."
    else
      puts article["lead_paragraph"]
    end
    puts "Read full article: #{article["web_url"]}"
  rescue
    binding.pry
    puts "There was a problem loading this article."
    nil
  end
  puts "=========================================================================================================================\n"
end
