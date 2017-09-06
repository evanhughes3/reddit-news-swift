import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class ArticlesControllerSpec: QuickSpec {
  override func spec() {
    describe("ArticlesController") {
      var articleService: ArticlesServiceMock!
      var subject: ArticlesController!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        articleService = ArticlesServiceMock()
        injector.bind(ArticlesService.self, toInstance: articleService)

        subject = injector.getInstance(ArticlesController.self) as! ArticlesController
        subject.loadViewIfNeeded()
      }

      describe("loading the view") {
        it("should display the correct header title") {
          expect(subject.todoHeaderLabel.text).to(equal("Todo's"))
        }

        it("should fetch the articles") {
          expect(articleService.didCallFetchArticles).to(equal(true))
        }
      }
    }
  }
}