class Controller
  def initialize
    @uri = URI("https://api.nytimes.com/svc/search/v2/articlesearch.json")
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def generate_query(input_date)
    @uri.query = URI.encode_www_form({
      "api-key" => "68f00f41fbff4bbca99eff2673a153bd",
      "begin_date" => input_date,
      "end_date" => input_date,
      "sort" => "newest"
    })
    request = Net::HTTP::Get.new(@uri.request_uri)
    result = JSON.parse(@http.request(request).body)
    result
  end

  def run
    input_date = View.get_date
    headlines = generate_query(input_date)
    View.print_headlines(headlines)
  end
end
