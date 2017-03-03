class View
  def self.get_date
    puts "Which day would you like headlines for?  Enter in YYYYMMDD format or leave blank for today."
    input_date = gets.chomp
    input_date = DateTime.now.strftime("%Y%m%d") if input_date == ""
  end

  def self.print_headlines(result)
    result["response"]["docs"].map  do |article|
      begin
        puts "\e[35m\e[4m#{article["headline"]["main"]}\e[0m\n"
        puts "#{article["byline"].to_h["original"]}"
        if article["lead_paragraph"].length > 120
          puts article["lead_paragraph"][0..117].strip+"..."
        else
          puts article["lead_paragraph"]
        end
        puts "Read full article: #{article["web_url"]}"
      rescue
        binding.pry
        puts "There was a problem loading this article."
      end
      puts "=========================================================================================================================\n"
    end
  end
end
