host 'www.opotto.com'

sitemap :site do
  # Root
  url root_url, last_mod: Time.now, change_freq: 'daily', priority: 1.0

  # Pages
  url page_path('about'), last_mod: Time.now, change_freq: 'daily', priority: 0.9
  url page_path('contact'), last_mod: Time.now, change_freq: 'daily', priority: 0.9
end

ping_with "https://#{host}/sitemap.xml"
