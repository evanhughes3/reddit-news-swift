@testable import reddit_news_swift

class ArticlesServiceMock: ArticlesService {
  var didCallFetchArticles: Bool = true

  func fetchArticles() -> Array<Article> {
    didCallFetchArticles = true
    return []
  }

  required init(jsonClient: JSONClient = JSONClientMock()) {
    
  }
}