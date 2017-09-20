import CBGPromise
@testable import reddit_news_swift

class ArticlesServiceMock: ArticlesServiceProtocol {
  let promise = Promise<ArticlesResponse>()
  var didCallFetchArticles: Bool = false

  func fetchArticles() -> Future<ArticlesResponse> {
    didCallFetchArticles = true
    return promise.future
  }
}