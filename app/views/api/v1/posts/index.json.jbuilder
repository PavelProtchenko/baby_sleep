json.cache! @posts do
  json.updated_at @last_updated_post[0]['updated_at'].strftime('%Y-%m-%d %H:%M:%S.%6N')
  json.updated @posts.each do |post|
    if post.publication == 'published'
      json.id post.id
      json.title post.title
      json.description post.description
      json.body sanitize(post.body, tags: %w(strong em a i h1 ul li ol br), attributes: %w(href)).gsub(/\n/, '')
      json.image_url post.image_url.url ? post.image_url.url : ''
      json.position post.position
    end
  end
  json.deleted @posts.where(publication: 'un-published').pluck(:id)
end
