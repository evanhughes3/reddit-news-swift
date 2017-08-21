import UIKit
import Quick
import Nimble
@testable import reddit_news_swift

class ArticlesControllerSpec: QuickSpec {
  override func spec() {
    describe("ArticlesController") {
      var articleService: ArticleServiceMock!
      var subject: ArticlesController!

      beforeEach {
        articleService = ArticleServiceMock();

        subject = ArticlesController(articlesService: articleService)
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