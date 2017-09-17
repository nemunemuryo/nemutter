require 'twitter'
require 'highline'

client = Twitter::REST::Client.new do |config|
          config.consumer_key        = "your_consumer_key"
          config.consumer_secret     = "your_consumer_secret"
          config.access_token        = "your_access_token"
          config.access_token_secret = "your_access_token_secret"
end

# 引数で機能選択
case ARGV[0]
when "tweet"
  # ツイートするよ
  tweet = ARGV[1].split(" ")
  client.update(tweet.join("\n"))
when "tl"
  # 自分のTLを見れるよ
  client.home_timeline(count: 10).reverse_each do |tweet|
    h = HighLine.new
    puts h.color(tweet.user.name, :rgb_c70067, :bold) + ": #{h.color(tweet.user.screen_name, :rgb_328cc1, :underline)}\n" + h.color(tweet.text, :rgb_0f1626)
    puts "#{h.color("Fav:", :rgb_f19f4d)} #{tweet.favorite_count}, #{h.color("RT:", :rgb_007849)} #{tweet.retweet_count}"
    puts
  end
end
