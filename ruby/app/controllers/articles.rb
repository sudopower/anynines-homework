class ArticleController
  def create_article(article)
    article_not_exists =  (Article.where(:title => article['title']).empty?)

    return { ok: false, msg: 'Article with given title already exists' } unless article_not_exists

    new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
    new_article.save

    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.where(id: id).first

    return { ok: false, msg: 'Article could not be found' } unless !article.nil?

    article.title = new_data['title']
    article.content = new_data['content']
    article.save

    { ok: true , obj: article}
  rescue StandardError
    { ok: false }
  end

  def get_article(id)
    res = Article.where(:id => id)

    if res.empty?
      { ok: false, msg: 'Article not found' }
    else
      { ok: true, data: res.first }
    end
  rescue StandardError
    { ok: false }
  end

  def delete_article(id)
    delete_count = Article.where(:id => id).delete_all

    if delete_count == 0
      { ok: false , msg: 'Article does not exist' }
    else
      { ok: true, delete_count: delete_count }
    end
  end

  def get_batch
    res = Article.all

    if res.empty?
      { ok: false, msg: 'No Articles found' }
    else
      { ok: true, data: res }
    end
  rescue StandardError
    { ok: false }
  end
end
