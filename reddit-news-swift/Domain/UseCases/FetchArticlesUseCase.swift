import Foundation
@testable import reddit_news_swift

protocol FetchArticlesUseCaseObserver {
  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol, 
                            didFetchArticles articles: [Article])

  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol,
                            didFailWithError error: NetworkError)
}

protocol FetchArticlesUseCaseProtocol {
  func fetchArticlesWithObserver(_ observer: FetchArticlesUseCaseObserver)
}

class FetchArticlesUseCase: NSObject, FetchArticlesUseCaseProtocol {
  var articlesService: ArticlesServiceProtocol

  init(articlesService: ArticlesServiceProtocol) {
    self.articlesService = articlesService
    super.init()
  }

  func fetchArticlesWithObserver(_ observer: FetchArticlesUseCaseObserver) {
    let future = self.articlesService.fetchArticles()

    future.then { response in
      switch response {
      case .Success(let articles):
        observer.fetchArticlesUseCase(self, didFetchArticles: articles)
      
      case .Error(let error):
        observer.fetchArticlesUseCase(self, didFailWithError: error)
      }
    }
  }
}