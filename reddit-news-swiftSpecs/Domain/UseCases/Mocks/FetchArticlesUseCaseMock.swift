import Foundation
@testable import reddit_news_swift

class FetchArticlesUseCaseMock: FetchArticlesUseCaseProtocol {
  var didCallFetchArticles: Bool = false
  var incomingObserver: FetchArticlesUseCaseObserver!

  func fetchArticlesWithObserver(_ observer: FetchArticlesUseCaseObserver) {
    didCallFetchArticles = true;
    incomingObserver = observer;
  }
}