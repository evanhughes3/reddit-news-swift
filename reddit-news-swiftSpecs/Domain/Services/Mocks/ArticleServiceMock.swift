@testable import reddit_news_swift

class ArticlesServiceMock: FetchArticlesService {
  var didCallFetchArticles: Bool = true

  func fetchArticles() -> Array<Article> {
    didCallFetchArticles = true
    return []
  }
}