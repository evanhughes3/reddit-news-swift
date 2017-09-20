import Foundation
@testable import reddit_news_swift

class FetchArticlesUseCaseObserverMock: FetchArticlesUseCaseObserver {
  var incomingArticles: [Article]?
  var incomingError: NetworkError?
  
  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol, didFetchArticles articles: [Article]) {
    incomingArticles = articles;
  }

  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol, didFailWithError error: NetworkError) {
    incomingError = error;
  }
}
