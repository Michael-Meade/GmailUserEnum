require 'httparty'
require 'optparse'
def detect_valid(email)
	r = HTTParty.get("https://mail.google.com/mail/gxlu?email=#{email}")
	return true if !r.header['set-cookie'].nil?
end
o = {
  "list": "emails.txt",
  "out":  "gmails.txt"
}
OptionParser.new do |parser|
 parser.on('--list [LIST]', "Email list") do |m|
  o[:list] = m
 end
 parser.on('--out [OUT]', "The file where valid gmails emails are stored.") do |m|
  o[:out] = m
 end
end.parse!

if File.exist?(o[:list])
	File.readlines(o[:list]).each do |e|
		File.open(o[:out], 'a') { |f| f.write(e) } if detect_valid(e)
	end
else
	puts "[+] #{o[:list]} does not exists."
end
