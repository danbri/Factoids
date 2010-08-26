#!/usr/bin/ruby -rubygems
#
# Crawls index pages from http://www.politifact.com/truth-o-meter/statements/
# Dumps index pages into cache/ dir. Depends on curl for now; lazy.
#
# author: danbri@danbri.org
# license: public domain (the script not their data!)

def fetch(url) 
  puts "Fetching url #{url}";
  str = `curl -silent "#{url}"`
  return str
end

def stash(text, url, i)
  puts "Stashing text in #{CACHE} for #{url} - page #{i}"
   File.open("cache/page-#{i}.html",'w') do |f|
     f.puts(text)
   end

   File.open("cache/log.txt",'a') do |f|
     f.puts("#{url}	#{i}")
   end
end

p1 = "http://www.politifact.com/truth-o-meter/statements/"
p1_txt = stash(fetch(p1), p1, 1)
p1_txt =~ /Page 1 of (\d+)/
max = $1
puts "Pages: #{max}"
i = 2
while ( i <= max.to_i ) do
  url = "http://www.politifact.com/truth-o-meter/statements/?page=#{i}"
  puts stash(fetch(url), url, i)
  i = i + 1
end
