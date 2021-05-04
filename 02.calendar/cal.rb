require 'date'
require 'optparse'

# 初期値
today = Date.today
year = today.year
month = today.month

# コマンドラインからの年度の引数取得
opt = OptionParser.new
opt.on('-y', '--year [ITEM]', 'select year') do |val|
  year = val.to_i unless val.nil?
end

# コマンドラインからの月の引数取得
opt.on('-m', '--month [ITEM]', 'select month') do |val|
  month = val.to_i unless val.nil?
end

opt.parse(ARGV)

# 月初日と月末日を取得する
first_day = Date.new(year, month)
last_day  = Date.new(year, month, -1)

# 月初日と月末日を取得する
day_of_the_week = %W[\u65E5 \u6708 \u706B \u6C34 \u6728 \u91D1 \u571F]

# 月初日の曜日の分だけスペースを挿入
result = []
first_day.wday.times do
  result.push('   ')
end

# 日にちの分だけ繰り返す
# 土曜日のみ末尾に改行処理
(first_day..last_day).each do |cursor_day|
  if 0 == cursor_day.wday
    line_day = cursor_day.day.to_s + "\n"
    result.push(line_day)
  else
    result.push(cursor_day.day.to_s + ' ')
  end
end

# 最終的な出力
p month.to_s + '月 ' + year.to_s
p day_of_the_week.join(' ')
print result.join('')
