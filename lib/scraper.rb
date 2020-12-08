
require 'open-uri'
require 'pry'

class Scraper
  

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_card = html.css("div.student-card")
    student_array = []

    student_card.each do |student|
      student_hash = {}

      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a")[0]["href"]

      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    student = {}

    links = html.css(".social-icon-container a")
    
    student[:profile_quote] = html.css(".profile-quote").text
    student[:bio] = html.css("p").text

    links.map do |link|
      if link.to_s.include?("twitter")
        student[:twitter] = link["href"]
      elsif link.to_s.include?("linkedin")
        student[:linkedin] = link["href"]
      elsif link.to_s.include?("github")
        student[:github] = link["href"]
      elsif link.to_s.include?(".com")
        student[:blog] = link["href"]
      end
    end
    student
    
  end
end
