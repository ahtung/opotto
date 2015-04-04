# encoding : utf-8

MoneyRails.configure do |config|
  config.default_currency = :usd
  config.no_cents_if_whole = false
end
