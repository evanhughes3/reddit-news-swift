import UIKit
import Quick
import Nimble
import Blindside
import CBGPromise
@testable import reddit_news_swift

class FetchArticlesUseCaseSpec: QuickSpec {
  override func spec() {
    describe("FetchArticlesUseCase") {
      var articlesService: ArticlesServiceMock!
      var subject: FetchArticlesUseCase!

      beforeEach {
        let injector = InjectorProvider.injector()

        articlesService = ArticlesServiceMock();
        injector.bind(ArticlesService.self, toInstance: articlesService)

        subject = injector.getInstance(FetchArticlesUseCase.self) as! FetchArticlesUseCase
      }

      describe("-fetchArticlesWithObserver") {
        var observer: FetchArticlesUseCaseObserverMock!

        beforeEach {
          observer = FetchArticlesUseCaseObserverMock()

          subject.fetchArticlesWithObserver(observer)
        }

        it("should fetch the articles") {
          expect(articlesService.didCallFetchArticles).to(equal(true))
        }

        describe("successfully fetching the articles") {
          var articles: [Article]!
          
          beforeEach {
            let article1 = Article(title: "title1", url: "url1")
            let article2 = Article(title: "title2", url: "url2")
            articles = [article1, article2]

            articlesService.promise.resolve(.Success(articles))
          }

          it("should notify the observer") {
            expect(observer.incomingArticles).to(equal(articles))
          }
        }

        describe("failing to fetch the articles") {
          var error: NetworkError!

          beforeEach {
            error = NetworkError(localizedTitle: "as", localizedDescription: "as", code: 500)
            articlesService.promise.resolve(.Error(error))
          }

          it("should reject the promise") {
            expect(observer.incomingError) == error
          }
        }
      }
    }
  }
}