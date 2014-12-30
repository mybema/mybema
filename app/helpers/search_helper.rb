module SearchHelper
  def search_result_link result
    if result._type == 'discussion'
      link_to result.title, discussion_path(result.slug)
    else
      link_to result.title, article_path(result.id)
    end
  end
end