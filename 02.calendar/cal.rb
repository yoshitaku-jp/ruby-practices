require 'date'
require 'optparse'

# 初期値
today = Date.today
year = today.year
month = today.month

# コマンドラインからの年度の引数取得
opt = OptionParser.new
opt.on('-y', '--year ITEM', 'select year') do |val|
  year = val.to_i unless val.nil?
end

# コマンドラインからの月の引数取得
opt.on('-m', '--month ITEM', 'select month') do |val|
  month = val.to_i unless val.nil?
end

opt.parse(ARGV)

# 月初日と月末日を取得する
first_day = Date.new(year, month)
last_day  = Date.new(year, month, -1)

# 曜日を定義する
day_of_the_week = %w[日 月 火 水 木 金 土]

# 月初日の曜日の分だけスペースを挿入
result = []
first_day.wday.times do
  result.push('   ')
end

# 日にちの分だけ繰り返す
# 土曜日のみ末尾に改行処理
(first_day..last_day).each do |cursor_day|
  result_day = cursor_day.day.to_s.rjust(3, ' ')

  result_day += "\n" if cursor_day.saturday?

  result.push(result_day)
end

month_year = month.to_s + '月' + year.to_s

# 最終的な出力
puts month_year.to_s.center(20)
puts day_of_the_week.join(' ')
print result.join('')
