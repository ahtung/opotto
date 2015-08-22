# Rack
module Rack
  # Attack
  class Attack
    spammers = ENV['SPAMMERS'].split(/,\s*/)
    spammer_regexp = Regexp.union(spammers)
    blacklist('block referer spam') do |request|
      request.referer =~ spammer_regexp
    end
  end
end
