@testable import reddit_news_swift

class ArticleServiceMock: ArticleService {
  var didCallFetchArticles: Bool = false

  func fetchArticles() {
    didCallFetchArticles = true
  }
}