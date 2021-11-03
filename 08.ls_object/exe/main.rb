require_relative '../lib/ls'

require 'optparse'
require 'etc'

opt = OptionParser.new

$option = []

# コマンドラインからのaの引数取得
opt.on('-a') do |_val|
  $option << 'a'
end

# コマンドラインからのlの引数取得
opt.on('-l') do |_val|
  $option << 'l'
end

# コマンドラインからのrの引数取得
opt.on('-r') do |_val|
  $option << 'r'
end

opt.parse(ARGV)

LS.new($option)