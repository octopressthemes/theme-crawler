require 'pry'
require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'active_support/core_ext/string'

THEMES_URL = "https://github.com/imathis/octopress/wiki/3rd-Party-Octopress-Themes"

doc = Nokogiri::HTML(open(THEMES_URL))

%w(_posts screenshots).each do |folder|
  Dir.mkdir(folder) unless File.directory?(folder)
end

year = 2015

doc.xpath("//table//tbody//tr")[0..1].each do |tr|
  tds = tr.xpath("./td")

  first_td  = tds[0]
  second_td = tds[1]
  third_td  = tds[2]

  # Hash for prefilling the front matter YAML for jekyll.
  post = {}

  post[:title] = first_td.xpath("./a")[0].text

  # encoding fixes
  if post[:title] =~ /nigspress/
    post[:title] = "Konigspress"
  end

  post[:slug] = post[:title].underscore.dasherize

  post[:github_link] = first_td.xpath("./a")[0].attributes['href'].value

  if second_td.xpath("./a").count == 2

  else
    link_text = second_td.xpath('./a').text

    if link_text == 'Preview'
      post[:demo_preview] = second_td.xpath('./a')[0].attributes['href'].value
      post[:demo_screenshot] = nil
    elsif link_text == 'Screenshot' || link_text == 'Screenshots'
      post[:demo_screenshot] = second_td.xpath('./a')[0].attributes['href'].value
      post[:demo_preview] = nil
    else
      binding.pry
    end
  end

  post[:description] = third_td.text

  year = year - 1
  File.open("_posts/#{year}-12-02-#{post[:slug]}.md", 'w') do |f|
    f.write(post.to_yaml.gsub("\n:", "\n"))
    f.write("---")
  end

  if post[:demo_preview]
    `webkit2png -C --clipwidth=400 --clipheight=300 --dir="screenshots" --filename="#{post[:slug]}" #{post[:demo_preview]}`
  end
end

# def write_to_console(post)
#   post.each do |k, v|
#     puts "#{k}: #{v}"
#   end
#   puts "---------"
# end
