require 'watir'
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print'
require_relative 'credentials'

username = $username
password = $password
users = ["baddiewinkle", "70sbabes", "katdenningsss"]

# Open Browser, Navigate to Login Page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

#Navigate to Username and Password Fields, Inject Credentials.
ap "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"

# Click Login Button
browser.button(:class => '_ah57t _84y62 _i46jh _rmr7s').click
sleep(2)
while true
  users.each { |val|
    # Navigate to user's Page
    browser.goto "instagram.com/#{val}/"

    # If not Following then Follow
    if browser.button(:class => '_ah57t _84y62 _frcv2 _rmr7s').exists?
      ap "Following #{val}"
      browser.button(:class => '_ah57t _84y62 _frcv2 _rmr7s').click
    elsif browser.button(:class => '_ah57t _6y2ah _frcv2 _rmr7s').exists?
      ap "Unfollowing #{val}"
      browser.button(:class => '_ah57t _6y2ah _frcv2 _rmr7s').click
    end
  }
  puts "------- #{Time.now} -------"
  sleep(30)
end

Pry.start(binding)
