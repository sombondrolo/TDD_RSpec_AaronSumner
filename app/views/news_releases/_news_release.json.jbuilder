json.extract! news_release, :id, :title, :released_on, :body, :created_at, :updated_at
json.url news_release_url(news_release, format: :json)
